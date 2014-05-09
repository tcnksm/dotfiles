(function() {
  var $, EditorView, HighlightLineView, View, lines, underlineStyleInUsed, underlineStyles, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ref = require('atom'), EditorView = _ref.EditorView, View = _ref.View;

  $ = require('atom').$;

  lines = [];

  underlineStyles = ["solid", "dotted", "dashed"];

  underlineStyleInUsed = '';

  module.exports = {
    configDefaults: {
      allEnable: true,
      enableBackgroundColor: true,
      backgroundRgbColor: "100, 100, 100",
      opacity: "50%",
      underline: {
        solid: false,
        dotted: false,
        dashed: false
      },
      underlineRgbColor: "255, 165, 0"
    },
    activate: function() {
      return atom.workspaceView.eachEditorView(function(editorView) {
        var line;
        if (editorView.attached && editorView.getPane()) {
          line = new HighlightLineView(editorView);
          lines.push(line);
          return editorView.underlayer.append(line);
        }
      });
    },
    deactivate: function() {
      var line, _i, _len;
      for (_i = 0, _len = lines.length; _i < _len; _i++) {
        line = lines[_i];
        line.destroy();
      }
      return lines = [];
    }
  };

  HighlightLineView = (function(_super) {
    __extends(HighlightLineView, _super);

    function HighlightLineView() {
      this.showHighlight = __bind(this.showHighlight, this);
      this.updateSelectedLine = __bind(this.updateSelectedLine, this);
      this.destroy = __bind(this.destroy, this);
      this.updateSetting = __bind(this.updateSetting, this);
      return HighlightLineView.__super__.constructor.apply(this, arguments);
    }

    HighlightLineView.content = function() {
      return this.div({
        "class": 'highlight-view hidden'
      });
    };

    HighlightLineView.prototype.initialize = function(editorView) {
      var underlineStyle, _i, _len;
      this.editorView = editorView;
      this.defaultColors = {
        backgroundRgbColor: "100, 100, 100",
        underlineColor: "255, 165, 0"
      };
      this.defaultOpacity = 50;
      this.subscribe(this.editorView, 'cursor:moved', this.updateSelectedLine);
      this.subscribe(this.editorView, 'selection:changed', this.updateSelectedLine);
      this.subscribe(this.editorView.getPane(), 'pane:active-item-changed', this.updateSelectedLine);
      atom.workspaceView.on('pane:item-removed', this.destroy);
      this.updateUnderlineStyle();
      for (_i = 0, _len = underlineStyles.length; _i < _len; _i++) {
        underlineStyle = underlineStyles[_i];
        this.subscribe(atom.config.observe("highlight-line.underline." + underlineStyle, {
          callNow: false
        }, this.updateSetting));
      }
      return this.updateSelectedLine();
    };

    HighlightLineView.prototype.updateUnderlineStyle = function() {
      var underlineStyle, _i, _len, _results;
      underlineStyleInUsed = '';
      this.marginHeight = 0;
      _results = [];
      for (_i = 0, _len = underlineStyles.length; _i < _len; _i++) {
        underlineStyle = underlineStyles[_i];
        if (atom.config.get("highlight-line.underline." + underlineStyle)) {
          underlineStyleInUsed = underlineStyle;
          _results.push(this.marginHeight = -1);
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    HighlightLineView.prototype.updateSetting = function(value) {
      if (value) {
        if (underlineStyleInUsed) {
          atom.config.set("highlight-line.underline." + underlineStyleInUsed, false);
        }
      }
      return this.updateUnderlineStyle();
    };

    HighlightLineView.prototype.destroy = function() {
      var editor, found, _i, _len, _ref1;
      found = false;
      _ref1 = atom.workspaceView.getEditorViews();
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        editor = _ref1[_i];
        if (editor.id === this.editorView.id) {
          found = true;
        }
      }
      if (found) {
        return;
      }
      atom.workspaceView.off('pane:item-removed', this.destroy);
      this.unsubscribe();
      this.remove();
      return this.detach();
    };

    HighlightLineView.prototype.updateSelectedLine = function() {
      this.resetBackground();
      if (atom.config.get('highlight-line.allEnable')) {
        return this.showHighlight();
      }
    };

    HighlightLineView.prototype.resetBackground = function() {
      return $('.line').css('background-color', '').css('border-bottom', '').css('margin-bottom', '');
    };

    HighlightLineView.prototype.makeLineStyleAttr = function() {
      var bgColor, bgRgba, styleAttr, ulColor, ulRgba;
      styleAttr = '';
      if (atom.config.get('highlight-line.enableBackgroundColor')) {
        bgColor = this.wantedColor('backgroundRgbColor');
        bgRgba = "rgba(" + bgColor + ", " + (this.wantedOpacity()) + ")";
        styleAttr += "background-color: " + bgRgba + ";";
      }
      if (underlineStyleInUsed) {
        ulColor = this.wantedColor('underlineRgbColor');
        ulRgba = "rgba(" + ulColor + ",1)";
        styleAttr += "border-bottom: 1px " + underlineStyleInUsed + " " + ulRgba + ";";
        styleAttr += "margin-bottom: " + this.marginHeight + "px;";
      }
      return styleAttr;
    };

    HighlightLineView.prototype.showHighlight = function() {
      var cursorView, cursorViews, lineElement, range, styleAttr, _i, _len, _results;
      styleAttr = this.makeLineStyleAttr();
      if (styleAttr) {
        cursorViews = this.editorView.getCursorViews();
        _results = [];
        for (_i = 0, _len = cursorViews.length; _i < _len; _i++) {
          cursorView = cursorViews[_i];
          range = cursorView.getScreenPosition();
          lineElement = this.editorView.lineElementForScreenRow(range.row);
          if (this.editorView.editor.getSelection().isSingleScreenLine()) {
            _results.push($(lineElement).attr('style', styleAttr));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      }
    };

    HighlightLineView.prototype.wantedColor = function(color) {
      var wantedColor;
      wantedColor = atom.config.get("highlight-line." + color);
      if ((wantedColor != null ? wantedColor.split(',').length : void 0) !== 3) {
        wantedColor = this.defaultColors[color];
      }
      return wantedColor;
    };

    HighlightLineView.prototype.wantedOpacity = function() {
      var wantedOpacity;
      wantedOpacity = atom.config.get('highlight-line.opacity');
      if (wantedOpacity) {
        wantedOpacity = parseFloat(wantedOpacity);
      } else {
        wantedOpacity = this.defaultOpacity;
      }
      return (wantedOpacity / 100).toString();
    };

    return HighlightLineView;

  })(View);

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLDBGQUFBO0lBQUE7O21TQUFBOztBQUFBLEVBQUEsT0FBcUIsT0FBQSxDQUFRLE1BQVIsQ0FBckIsRUFBQyxrQkFBQSxVQUFELEVBQWEsWUFBQSxJQUFiLENBQUE7O0FBQUEsRUFDQyxJQUFLLE9BQUEsQ0FBUSxNQUFSLEVBQUwsQ0FERCxDQUFBOztBQUFBLEVBR0EsS0FBQSxHQUFRLEVBSFIsQ0FBQTs7QUFBQSxFQUlBLGVBQUEsR0FBa0IsQ0FBQyxPQUFELEVBQVMsUUFBVCxFQUFrQixRQUFsQixDQUpsQixDQUFBOztBQUFBLEVBS0Esb0JBQUEsR0FBdUIsRUFMdkIsQ0FBQTs7QUFBQSxFQU9BLE1BQU0sQ0FBQyxPQUFQLEdBQ0U7QUFBQSxJQUFBLGNBQUEsRUFDRTtBQUFBLE1BQUEsU0FBQSxFQUFXLElBQVg7QUFBQSxNQUNBLHFCQUFBLEVBQXVCLElBRHZCO0FBQUEsTUFFQSxrQkFBQSxFQUFvQixlQUZwQjtBQUFBLE1BR0EsT0FBQSxFQUFTLEtBSFQ7QUFBQSxNQUlBLFNBQUEsRUFDRTtBQUFBLFFBQUEsS0FBQSxFQUFPLEtBQVA7QUFBQSxRQUNBLE1BQUEsRUFBUSxLQURSO0FBQUEsUUFFQSxNQUFBLEVBQVEsS0FGUjtPQUxGO0FBQUEsTUFRQSxpQkFBQSxFQUFtQixhQVJuQjtLQURGO0FBQUEsSUFXQSxRQUFBLEVBQVUsU0FBQSxHQUFBO2FBQ1IsSUFBSSxDQUFDLGFBQWEsQ0FBQyxjQUFuQixDQUFrQyxTQUFDLFVBQUQsR0FBQTtBQUNoQyxZQUFBLElBQUE7QUFBQSxRQUFBLElBQUcsVUFBVSxDQUFDLFFBQVgsSUFBd0IsVUFBVSxDQUFDLE9BQVgsQ0FBQSxDQUEzQjtBQUNFLFVBQUEsSUFBQSxHQUFXLElBQUEsaUJBQUEsQ0FBa0IsVUFBbEIsQ0FBWCxDQUFBO0FBQUEs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
//# sourceURL=/Users/taichi.nakashima/.dotfiles/atom/packages/highlight-line/lib/highlight-line-view.coffee