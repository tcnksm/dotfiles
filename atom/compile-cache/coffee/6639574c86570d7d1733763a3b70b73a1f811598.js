(function() {
  var $, $$, AutocompleteView, Editor, Perf, Point, Q, Range, SelectListView, SimpleSelectListView, fuzzaldrin, minimatch, path, _, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  _ = require('underscore-plus');

  path = require('path');

  minimatch = require('minimatch');

  SimpleSelectListView = require('./simple-select-list-view');

  _ref = require('atom'), Editor = _ref.Editor, $ = _ref.$, $$ = _ref.$$, Range = _ref.Range, Point = _ref.Point, SelectListView = _ref.SelectListView;

  fuzzaldrin = require('fuzzaldrin');

  Perf = require('./perf');

  Q = require('q');

  module.exports = AutocompleteView = (function(_super) {
    __extends(AutocompleteView, _super);

    function AutocompleteView() {
      this.onChanged = __bind(this.onChanged, this);
      this.onSaved = __bind(this.onSaved, this);
      this.cursorMoved = __bind(this.cursorMoved, this);
      this.contentsModified = __bind(this.contentsModified, this);
      this.cancel = __bind(this.cancel, this);
      return AutocompleteView.__super__.constructor.apply(this, arguments);
    }

    AutocompleteView.prototype.currentBuffer = null;

    AutocompleteView.prototype.wordList = null;

    AutocompleteView.prototype.wordRegex = /\b\w*[a-zA-Z_]\w*\b/g;

    AutocompleteView.prototype.originalCursorPosition = null;

    AutocompleteView.prototype.aboveCursor = false;

    AutocompleteView.prototype.debug = false;

    AutocompleteView.prototype.initialize = function(editorView) {
      this.editorView = editorView;
      AutocompleteView.__super__.initialize.apply(this, arguments);
      this.addClass('autocomplete popover-list');
      this.editor = this.editorView.editor;
      if (this.currentFileBlacklisted()) {
        return;
      }
      this.handleEvents();
      return this.setCurrentBuffer(this.editor.getBuffer());
    };


    /*
     * Checks whether the current file is blacklisted
     */

    AutocompleteView.prototype.currentFileBlacklisted = function() {
      var blacklist, blacklistGlob, fileName, _i, _len;
      blacklist = atom.config.get("autocomplete-plus.fileBlacklist").split(",").map(function(s) {
        return s.trim();
      });
      fileName = path.basename(this.editor.getBuffer().getPath());
      for (_i = 0, _len = blacklist.length; _i < _len; _i++) {
        blacklistGlob = blacklist[_i];
        if (minimatch(fileName, blacklistGlob)) {
          return true;
        }
      }
      return false;
    };


    /*
     * Creates a view for the given item
     */

    AutocompleteView.prototype.viewForItem = function(_arg) {
      var word;
      word = _arg.word;
      return $$(function() {
        return this.li((function(_this) {
          return function() {
            return _this.span(word);
          };
        })(this));
      });
    };


    /*
     * Handles editor events
     */

    AutocompleteView.prototype.handleEvents = function() {
      this.list.on('mousewheel', function(event) {
        return event.stopPropagation();
      });
      if (!atom.config.get('autocomplete-plus.liveCompletion')) {
        this.editor.on('contents-modified', this.contentsModified);
      }
      this.editor.on('title-changed-subscription-removed', this.cancel);
      return this.editor.on('cursor-moved', this.cursorMoved);
    };


    /*
     * Return false so that the events don't bubble up to the editor
     */

    AutocompleteView.prototype.selectNextItemView = function() {
      AutocompleteView.__super__.selectNextItemView.apply(this, arguments);
      return false;
    };


    /*
     * Return false so that the events don't bubble up to the editor
     */

    AutocompleteView.prototype.selectPreviousItemView = function() {
      AutocompleteView.__super__.selectPreviousItemView.apply(this, arguments);
      return false;
    };


    /*
     * Don't really know what that does...
     */

    AutocompleteView.prototype.getCompletionsForCursorScope = function() {
      var completions, cursorScope;
      cursorScope = this.editor.scopesForBufferPosition(this.editor.getCursorBufferPosition());
      completions = atom.syntax.propertiesForScope(cursorScope, 'editor.completions');
      completions = completions.map(function(properties) {
        return _.valueForKeyPath(properties, 'editor.completions');
      });
      return _.uniq(_.flatten(completions));
    };


    /*
     * Generates the word list from the editor buffer(s)
     */

    AutocompleteView.prototype.buildWordList = function() {
      var buffer, buffers, matches, objectKeyBlacklist, p, word, wordHash, wordList, words, _i, _j, _k, _len, _len1, _len2;
      wordHash = {};
      if (atom.config.get('autocomplete-plus.includeCompletionsFromAllBuffers')) {
        buffers = atom.project.getBuffers();
      } else {
        buffers = [this.currentBuffer];
      }
      matches = [];
      p = new Perf("Building word list", {
        debug: this.debug
      });
      p.start();
      for (_i = 0, _len = buffers.length; _i < _len; _i++) {
        buffer = buffers[_i];
        matches.push(buffer.getText().match(this.wordRegex));
      }
      matches.push(this.getCompletionsForCursorScope());
      words = _.flatten(matches);
      for (_j = 0, _len1 = words.length; _j < _len1; _j++) {
        word = words[_j];
        if (wordHash[word] == null) {
          wordHash[word] = true;
        }
      }
      wordList = Object.keys(wordHash);
      objectKeyBlacklist = ['toString', 'toLocaleString', 'valueOf', 'hasOwnProperty', 'isPrototypeOf', 'propertyIsEnumerable', 'constructor'];
      for (_k = 0, _len2 = objectKeyBlacklist.length; _k < _len2; _k++) {
        word = objectKeyBlacklist[_k];
        if (__indexOf.call(words, word) >= 0) {
          wordList.push(word);
        }
      }
      this.wordList = wordList;
      return p.stop();
    };


    /*
     * Handles confirmation (the user pressed enter)
     */

    AutocompleteView.prototype.confirmed = function(match) {
      var position;
      this.editor.getSelection().clear();
      this.cancel();
      if (!match) {
        return;
      }
      this.replaceTextWithMatch(match);
      position = this.editor.getCursorBufferPosition();
      return this.editor.setCursorBufferPosition([position.row, position.column]);
    };


    /*
     * Activates
     */

    AutocompleteView.prototype.setActive = function() {
      AutocompleteView.__super__.setActive.apply(this, arguments);
      return this.active = true;
    };


    /*
     * Clears the list, sets back the cursor, focuses the editor and
     * detaches the list DOM element
     */

    AutocompleteView.prototype.cancel = function() {
      this.active = false;
      this.list.empty();
      this.editorView.focus();
      return this.detach();
    };

    AutocompleteView.prototype.contentsModified = function() {
      var prefix, selection, suggestions;
      if (this.active) {
        this.detach();
        this.list.empty();
        this.editorView.focus();
      }
      selection = this.editor.getSelection();
      prefix = this.prefixOfSelection(selection);
      if (!prefix.length) {
        return;
      }
      suggestions = this.findMatchesForWord(prefix);
      if (!suggestions.length) {
        return;
      }
      this.setItems(suggestions);
      this.editorView.appendToLinesView(this);
      this.setPosition();
      return this.setActive();
    };

    AutocompleteView.prototype.cursorMoved = function(data) {
      if (!data.textChanged && this.active) {
        return this.cancel();
      }
    };

    AutocompleteView.prototype.onSaved = function() {
      this.buildWordList();
      return this.cancel();
    };

    AutocompleteView.prototype.onChanged = function(e) {
      var _ref1;
      if ((_ref1 = e.newText) === "\n" || _ref1 === " ") {
        this.addLastWordToList(e.newText === "\n");
      }
      if (e.newText.length === 1) {
        return this.contentsModified();
      } else {
        return this.cancel();
      }
    };

    AutocompleteView.prototype.findMatchesForWord = function(prefix) {
      var p, results, word, words;
      p = new Perf("Finding matches for '" + prefix + "'", {
        debug: this.debug
      });
      p.start();
      words = fuzzaldrin.filter(this.wordList, prefix);
      results = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = words.length; _i < _len; _i++) {
          word = words[_i];
          if (word !== prefix) {
            _results.push({
              prefix: prefix,
              word: word
            });
          }
        }
        return _results;
      })();
      p.stop();
      return results;
    };

    AutocompleteView.prototype.setPosition = function() {
      var height, left, potentialBottom, potentialTop, top, _ref1;
      _ref1 = this.editorView.pixelPositionForScreenPosition(this.editor.getCursorScreenPosition()), left = _ref1.left, top = _ref1.top;
      height = this.outerHeight();
      potentialTop = top + this.editorView.lineHeight;
      potentialBottom = potentialTop - this.editorView.scrollTop() + height;
      if (this.aboveCursor || potentialBottom > this.editorView.outerHeight()) {
        this.aboveCursor = true;
        return this.css({
          left: left,
          top: top - height,
          bottom: 'inherit'
        });
      } else {
        return this.css({
          left: left,
          top: potentialTop,
          bottom: 'inherit'
        });
      }
    };


    /*
     * Replaces the current prefix with the given match
     */

    AutocompleteView.prototype.replaceTextWithMatch = function(match) {
      var buffer, cursorPosition, infixLength, selection, startPosition;
      selection = this.editor.getSelection();
      startPosition = selection.getBufferRange().start;
      buffer = this.editor.getBuffer();
      selection.deleteSelectedText();
      cursorPosition = this.editor.getCursorBufferPosition();
      buffer["delete"](Range.fromPointWithDelta(cursorPosition, 0, -match.prefix.length));
      this.editor.insertText(match.word);
      infixLength = match.word.length - match.prefix.length;
      return this.editor.setSelectedBufferRange([startPosition, [startPosition.row, startPosition.column + infixLength]]);
    };


    /*
     * Finds and returns the content before the current cursor position
     */

    AutocompleteView.prototype.prefixOfSelection = function(selection) {
      var lineRange, prefix, selectionRange;
      selectionRange = selection.getBufferRange();
      lineRange = [[selectionRange.start.row, 0], [selectionRange.end.row, this.editor.lineLengthForBufferRow(selectionRange.end.row)]];
      prefix = "";
      this.currentBuffer.scanInRange(this.wordRegex, lineRange, function(_arg) {
        var match, prefixOffset, range, stop;
        match = _arg.match, range = _arg.range, stop = _arg.stop;
        if (range.start.isGreaterThan(selectionRange.end)) {
          stop();
        }
        if (range.intersectsWith(selectionRange)) {
          prefixOffset = selectionRange.start.column - range.start.column;
          if (range.start.isLessThan(selectionRange.start)) {
            return prefix = match[0].slice(0, prefixOffset);
          }
        }
      });
      return prefix;
    };


    /*
     * Finds the last typed word. If newLine is set to true, it looks
     * for the last word in the previous line.
     */

    AutocompleteView.prototype.lastTypedWord = function(newLine) {
      var lastWord, lineRange, maxColumn, row, selectionRange;
      selectionRange = this.editor.getSelection().getBufferRange();
      row = selectionRange.start.row;
      if (newLine) {
        row--;
      }
      if (newLine) {
        maxColumn = this.editor.lineLengthForBufferRow(row);
      } else {
        maxColumn = selectionRange.start.column;
      }
      lineRange = [[row, 0], [row, maxColumn]];
      lastWord = null;
      this.currentBuffer.scanInRange(this.wordRegex, lineRange, function(_arg) {
        var match, range, stop;
        match = _arg.match, range = _arg.range, stop = _arg.stop;
        return lastWord = match[0];
      });
      return lastWord;
    };


    /*
     * As soon as the list is in the DOM tree, it calculates the
     * maximum width of all list items and resizes the list so that
     * all items fit
     *
     * @todo: Fix this. Doesn't work well yet.
     */

    AutocompleteView.prototype.afterAttach = function(onDom) {
      var widestCompletion;
      if (onDom) {
        widestCompletion = parseInt(this.css('min-width')) || 0;
        this.list.find('span').each(function() {
          return widestCompletion = Math.max(widestCompletion, $(this).outerWidth());
        });
        this.list.width(widestCompletion + 15);
        return this.width(this.list.outerWidth());
      }
    };


    /*
     * Updates the list's position when populating results
     */

    AutocompleteView.prototype.populateList = function() {
      var p;
      p = new Perf("Populating list", {
        debug: this.debug
      });
      p.start();
      AutocompleteView.__super__.populateList.apply(this, arguments);
      p.stop();
      return this.setPosition();
    };


    /*
     * Sets the current buffer
     */

    AutocompleteView.prototype.setCurrentBuffer = function(currentBuffer) {
      this.currentBuffer = currentBuffer;
      this.buildWordList();
      this.currentBuffer.on("saved", this.onSaved);
      if (atom.config.get('autocomplete-plus.liveCompletion')) {
        return this.currentBuffer.on("changed", this.onChanged);
      }
    };


    /*
     * Adds the last typed word to the wordList
     */

    AutocompleteView.prototype.addLastWordToList = function(newLine) {
      var lastWord;
      lastWord = this.lastTypedWord(newLine);
      if (!lastWord) {
        return;
      }
      if (this.wordList.indexOf(lastWord) < 0) {
        return this.wordList.push(lastWord);
      }
    };


    /*
     * Defines which key we would like to use for filtering
     */

    AutocompleteView.prototype.getFilterKey = function() {
      return 'word';
    };

    AutocompleteView.prototype.getModel = function() {
      return null;
    };

    AutocompleteView.prototype.dispose = function() {
      var _ref1, _ref2;
      this.editor.off("contents-modified", this.contentsModified);
      if ((_ref1 = this.currentBuffer) != null) {
        _ref1.off("changed", this.onChanged);
      }
      if ((_ref2 = this.currentBuffer) != null) {
        _ref2.off("saved", this.onSaved);
      }
      this.editor.off("contents-modified", this.contentsModified);
      this.editor.off("title-changed-subscription-removed", this.cancel);
      return this.editor.off("cursor-moved", this.cursorMoved);
    };

    return AutocompleteView;

  })(SimpleSelectListView);

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLGtJQUFBO0lBQUE7Ozt5SkFBQTs7QUFBQSxFQUFBLENBQUEsR0FBSSxPQUFBLENBQVEsaUJBQVIsQ0FBSixDQUFBOztBQUFBLEVBQ0EsSUFBQSxHQUFPLE9BQUEsQ0FBUSxNQUFSLENBRFAsQ0FBQTs7QUFBQSxFQUVBLFNBQUEsR0FBWSxPQUFBLENBQVEsV0FBUixDQUZaLENBQUE7O0FBQUEsRUFHQSxvQkFBQSxHQUF1QixPQUFBLENBQVEsMkJBQVIsQ0FIdkIsQ0FBQTs7QUFBQSxFQUlBLE9BQWlELE9BQUEsQ0FBUSxNQUFSLENBQWpELEVBQUMsY0FBQSxNQUFELEVBQVMsU0FBQSxDQUFULEVBQVksVUFBQSxFQUFaLEVBQWdCLGFBQUEsS0FBaEIsRUFBdUIsYUFBQSxLQUF2QixFQUE4QixzQkFBQSxjQUo5QixDQUFBOztBQUFBLEVBS0EsVUFBQSxHQUFhLE9BQUEsQ0FBUSxZQUFSLENBTGIsQ0FBQTs7QUFBQSxFQU1BLElBQUEsR0FBTyxPQUFBLENBQVEsUUFBUixDQU5QLENBQUE7O0FBQUEsRUFPQSxDQUFBLEdBQUksT0FBQSxDQUFRLEdBQVIsQ0FQSixDQUFBOztBQUFBLEVBU0EsTUFBTSxDQUFDLE9BQVAsR0FDTTtBQUNKLHVDQUFBLENBQUE7Ozs7Ozs7OztLQUFBOztBQUFBLCtCQUFBLGFBQUEsR0FBZSxJQUFmLENBQUE7O0FBQUEsK0JBQ0EsUUFBQSxHQUFVLElBRFYsQ0FBQTs7QUFBQSwrQkFFQSxTQUFBLEdBQVcsc0JBRlgsQ0FBQTs7QUFBQSwrQkFHQSxzQkFBQSxHQUF3QixJQUh4QixDQUFBOztBQUFBLCtCQUlBLFdBQUEsR0FBYSxLQUpiLENBQUE7O0FBQUEsK0JBS0EsS0FBQSxHQUFPLEtBTFAsQ0FBQTs7QUFBQSwrQkFPQSxVQUFBLEdBQVksU0FBRSxVQUFGLEdB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
//# sourceURL=/Users/taichi.nakashima/.dotfiles/atom/packages/autocomplete-plus/lib/autocomplete-view.coffee