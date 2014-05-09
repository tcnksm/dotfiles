(function() {
  var Clipboard, EditorView, Gist, GistView, View, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ref = require('atom'), EditorView = _ref.EditorView, View = _ref.View;

  Clipboard = require('clipboard');

  Gist = require('./gist-model');

  module.exports = GistView = (function(_super) {
    __extends(GistView, _super);

    function GistView() {
      return GistView.__super__.constructor.apply(this, arguments);
    }

    GistView.content = function() {
      return this.div({
        "class": "gist overlay from-top padded"
      }, (function(_this) {
        return function() {
          return _this.div({
            "class": "inset-panel"
          }, function() {
            _this.div({
              "class": "panel-heading"
            }, function() {
              _this.span({
                outlet: "title"
              });
              return _this.div({
                "class": "btn-toolbar pull-right",
                outlet: 'toolbar'
              }, function() {
                return _this.div({
                  "class": "btn-group"
                }, function() {
                  _this.button({
                    outlet: "privateButton",
                    "class": "btn"
                  }, "Private");
                  return _this.button({
                    outlet: "publicButton",
                    "class": "btn"
                  }, "Public");
                });
              });
            });
            return _this.div({
              "class": "panel-body padded"
            }, function() {
              _this.div({
                outlet: 'signupForm'
              }, function() {
                _this.subview('descriptionEditor', new EditorView({
                  mini: true,
                  placeholderText: 'Description'
                }));
                return _this.div({
                  "class": 'pull-right'
                }, function() {
                  return _this.button({
                    outlet: 'gistButton',
                    "class": 'btn btn-primary'
                  }, "Gist It");
                });
              });
              _this.div({
                outlet: 'progressIndicator'
              }, function() {
                return _this.span({
                  "class": 'loading loading-spinner-medium'
                });
              });
              return _this.div({
                outlet: 'urlDisplay'
              }, function() {
                return _this.span("All Done! the Gist's URL has been copied to your clipboard.");
              });
            });
          });
        };
      })(this));
    };

    GistView.prototype.initialize = function(serializeState) {
      this.handleEvents();
      this.gist = null;
      atom.workspaceView.command("gist-it:gist-current-file", (function(_this) {
        return function() {
          return _this.gistCurrentFile();
        };
      })(this));
      atom.workspaceView.command("gist-it:gist-selection", (function(_this) {
        return function() {
          return _this.gistSelection();
        };
      })(this));
      return atom.workspaceView.command("gist-it:gist-open-buffers", (function(_this) {
        return function() {
          return _this.gistOpenBuffers();
        };
      })(this));
    };

    GistView.prototype.serialize = function() {};

    GistView.prototype.destroy = function() {
      return this.detach();
    };

    GistView.prototype.handleEvents = function() {
      this.gistButton.on('click', (function(_this) {
        return function() {
          return _this.gistIt();
        };
      })(this));
      this.publicButton.on('click', (function(_this) {
        return function() {
          return _this.makePublic();
        };
      })(this));
      this.privateButton.on('click', (function(_this) {
        return function() {
          return _this.makePrivate();
        };
      })(this));
      this.descriptionEditor.on('core:confirm', (function(_this) {
        return function() {
          return _this.gistIt();
        };
      })(this));
      return this.descriptionEditor.on('core:cancel', (function(_this) {
        return function() {
          return _this.detach();
        };
      })(this));
    };

    GistView.prototype.gistCurrentFile = function() {
      var activeEditor;
      this.gist = new Gist();
      activeEditor = atom.workspace.getActiveEditor();
      this.gist.files[activeEditor.getTitle()] = {
        content: activeEditor.getText()
      };
      this.title.text("Gist Current File");
      return this.presentSelf();
    };

    GistView.prototype.gistSelection = function() {
      var activeEditor;
      this.gist = new Gist();
      activeEditor = atom.workspace.getActiveEditor();
      this.gist.files[activeEditor.getTitle()] = {
        content: activeEditor.getSelectedText()
      };
      this.title.text("Gist Selection");
      return this.presentSelf();
    };

    GistView.prototype.gistOpenBuffers = function() {
      var editor, _i, _len, _ref1;
      this.gist = new Gist();
      _ref1 = atom.workspace.getEditors();
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        editor = _ref1[_i];
        this.gist.files[editor.getTitle()] = {
          content: editor.getText()
        };
      }
      this.title.text("Gist Open Buffers");
      return this.presentSelf();
    };

    GistView.prototype.presentSelf = function() {
      this.showGistForm();
      atom.workspaceView.append(this);
      return this.descriptionEditor.focus();
    };

    GistView.prototype.gistIt = function() {
      this.showProgressIndicator();
      this.gist.description = this.descriptionEditor.getText();
      return this.gist.post((function(_this) {
        return function(response) {
          Clipboard.writeText(response.html_url);
          _this.showUrlDisplay();
          return setTimeout((function() {
            return _this.detach();
          }), 1000);
        };
      })(this));
    };

    GistView.prototype.makePublic = function() {
      this.publicButton.addClass('selected');
      this.privateButton.removeClass('selected');
      return this.gist.isPublic = true;
    };

    GistView.prototype.makePrivate = function() {
      this.privateButton.addClass('selected');
      this.publicButton.removeClass('selected');
      return this.gist.isPublic = false;
    };

    GistView.prototype.showGistForm = function() {
      if (this.gist.isPublic) {
        this.makePublic();
      } else {
        this.makePrivate();
      }
      this.descriptionEditor.setText(this.gist.description);
      this.toolbar.show();
      this.signupForm.show();
      this.urlDisplay.hide();
      return this.progressIndicator.hide();
    };

    GistView.prototype.showProgressIndicator = function() {
      this.toolbar.hide();
      this.signupForm.hide();
      this.urlDisplay.hide();
      return this.progressIndicator.show();
    };

    GistView.prototype.showUrlDisplay = function() {
      this.toolbar.hide();
      this.signupForm.hide();
      this.urlDisplay.show();
      return this.progressIndicator.hide();
    };

    return GistView;

  })(View);

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLGlEQUFBO0lBQUE7bVNBQUE7O0FBQUEsRUFBQSxPQUFxQixPQUFBLENBQVEsTUFBUixDQUFyQixFQUFDLGtCQUFBLFVBQUQsRUFBYSxZQUFBLElBQWIsQ0FBQTs7QUFBQSxFQUNBLFNBQUEsR0FBWSxPQUFBLENBQVEsV0FBUixDQURaLENBQUE7O0FBQUEsRUFHQSxJQUFBLEdBQU8sT0FBQSxDQUFRLGNBQVIsQ0FIUCxDQUFBOztBQUFBLEVBS0EsTUFBTSxDQUFDLE9BQVAsR0FDTTtBQUNKLCtCQUFBLENBQUE7Ozs7S0FBQTs7QUFBQSxJQUFBLFFBQUMsQ0FBQSxPQUFELEdBQVUsU0FBQSxHQUFBO2FBQ1IsSUFBQyxDQUFBLEdBQUQsQ0FBSztBQUFBLFFBQUEsT0FBQSxFQUFPLDhCQUFQO09BQUwsRUFBNEMsQ0FBQSxTQUFBLEtBQUEsR0FBQTtlQUFBLFNBQUEsR0FBQTtpQkFDMUMsS0FBQyxDQUFBLEdBQUQsQ0FBSztBQUFBLFlBQUEsT0FBQSxFQUFPLGFBQVA7V0FBTCxFQUEyQixTQUFBLEdBQUE7QUFDekIsWUFBQSxLQUFDLENBQUEsR0FBRCxDQUFLO0FBQUEsY0FBQSxPQUFBLEVBQU8sZUFBUDthQUFMLEVBQTZCLFNBQUEsR0FBQTtBQUMzQixjQUFBLEtBQUMsQ0FBQSxJQUFELENBQU07QUFBQSxnQkFBQSxNQUFBLEVBQVEsT0FBUjtlQUFOLENBQUEsQ0FBQTtxQkFDQSxLQUFDLENBQUEsR0FBRCxDQUFLO0FBQUEsZ0JBQUEsT0FBQSxFQUFPLHdCQUFQO0FBQUEsZ0JBQWlDLE1BQUEsRUFBUSxTQUF6QztlQUFMLEVBQXlELFNBQUEsR0FBQTt1QkFDdkQsS0FBQyxDQUFBLEdBQUQsQ0FBSztBQUFBLGtCQUFBLE9BQUEsRUFBTyxXQUFQO2lCQUFMLEVBQXlCLFNBQUEsR0FBQTtB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
//# sourceURL=/Users/taichi.nakashima/.dotfiles/atom/packages/gist-it/lib/gist-view.coffee