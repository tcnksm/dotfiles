(function() {
  var AutocompleteView, _;

  _ = require('underscore-plus');

  AutocompleteView = require('./autocomplete-view');

  module.exports = {
    configDefaults: {
      liveCompletion: false,
      includeCompletionsFromAllBuffers: false,
      fileBlacklist: ".*, *.md"
    },
    autocompleteViews: [],
    editorSubscription: null,
    activate: function() {
      return this.editorSubscription = atom.workspaceView.eachEditorView((function(_this) {
        return function(editor) {
          var autocompleteView;
          if (editor.attached && !editor.mini) {
            autocompleteView = new AutocompleteView(editor);
            editor.on('editor:will-be-removed', function() {
              if (!autocompleteView.hasParent()) {
                autocompleteView.remove();
              }
              autocompleteView.dispose();
              return _.remove(_this.autocompleteViews, autocompleteView);
            });
            return _this.autocompleteViews.push(autocompleteView);
          }
        };
      })(this));
    },
    deactivate: function() {
      var _ref;
      if ((_ref = this.editorSubscription) != null) {
        _ref.off();
      }
      this.editorSubscription = null;
      this.autocompleteViews.forEach(function(autocompleteView) {
        return autocompleteView.remove();
      });
      return this.autocompleteViews = [];
    }
  };

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLG1CQUFBOztBQUFBLEVBQUEsQ0FBQSxHQUFJLE9BQUEsQ0FBUSxpQkFBUixDQUFKLENBQUE7O0FBQUEsRUFDQSxnQkFBQSxHQUFtQixPQUFBLENBQVEscUJBQVIsQ0FEbkIsQ0FBQTs7QUFBQSxFQUdBLE1BQU0sQ0FBQyxPQUFQLEdBQ0U7QUFBQSxJQUFBLGNBQUEsRUFDRTtBQUFBLE1BQUEsY0FBQSxFQUFnQixLQUFoQjtBQUFBLE1BQ0EsZ0NBQUEsRUFBa0MsS0FEbEM7QUFBQSxNQUVBLGFBQUEsRUFBZSxVQUZmO0tBREY7QUFBQSxJQUtBLGlCQUFBLEVBQW1CLEVBTG5CO0FBQUEsSUFNQSxrQkFBQSxFQUFvQixJQU5wQjtBQUFBLElBUUEsUUFBQSxFQUFVLFNBQUEsR0FBQTthQUNSLElBQUMsQ0FBQSxrQkFBRCxHQUFzQixJQUFJLENBQUMsYUFBYSxDQUFDLGNBQW5CLENBQWtDLENBQUEsU0FBQSxLQUFBLEdBQUE7ZUFBQSxTQUFDLE1BQUQsR0FBQTtBQUN0RCxjQUFBLGdCQUFBO0FBQUEsVUFBQSxJQUFHLE1BQU0sQ0FBQyxRQUFQLElBQW9CLENBQUEsTUFBVSxDQUFDLElBQWxDO0FBQ0UsWUFBQSxnQkFBQSxHQUF1QixJQUFBLGdCQUFBLENBQWlCLE1BQWpCLENBQXZCLENBQUE7QUFBQSxZQUNBLE1BQU0sQ0FBQyxFQUFQLENBQVUsd0JBQVYsRUFBb0MsU0FBQSxHQUFBO0FBQ2xDLGNBQUEsSUFBQSxDQUFBLGdCQUFpRCxDQUFDLFNBQWpCLENBQUEsQ0FBakM7QUFBQSxnQkFBQSxnQkFBZ0IsQ0FBQyxNQUFqQixDQUFBLENBQUEsQ0FBQTtlQUFBO0FBQUEsY0FDQSxnQkFBZ0IsQ0FBQyxPQUFqQixDQUFBLENBREEsQ0FBQTtxQkFFQSxDQUFDLENBQUMsTUFBRixDQUFTLEtBQUMsQ0FBQSxpQkFBVixFQUE2QixnQkFBN0IsRUFIa0M7WUFBQSxDQUFwQyxDQURBLENBQUE7bUJBS0EsS0FBQyxDQUFBLGlCQUFpQixDQUFDLElBQW5CLENBQXdCLGdCQUF4QixFQU5GO1dBRHNEO1FBQUEsRUFBQTtNQUFBLENBQUEsQ0FBQSxDQUFBLElBQUEsQ0FBbEMsRUFEZDtJQUFBLENBUlY7QUFBQSxJQWtCQSxVQUFBLEVBQVksU0FBQSxHQUFBO0FBQ1YsVUFBQSxJQUFBOztZQUFtQixDQUFFLEdBQXJCLENBQUE7T0FBQTtBQUFBLE1BQ0EsSUFBQyxDQUFBLGtCQUFELEdBQXNCLElBRHRCLENBQUE7QUFBQSxNQUVBLElBQUMsQ0FBQSxpQkFBaUIsQ0FBQyxPQUFuQixDQUEyQixTQUFDLGdCQUFELEdBQUE7ZUFBc0IsZ0JBQWdCLENBQUMsTUFBakIsQ0FBQSxFQUF0QjtNQUFBLENBQTNCLENBRkEsQ0FBQTthQUdBLElBQUMsQ0FBQSxpQkFBRCxHQUFxQixHQUpYO0lBQUEsQ0FsQlo7R0FKRixDQUFBO0FBQUEiCn0=
//# sourceURL=/Users/taichi.nakashima/.dotfiles/atom/packages/autocomplete-plus/lib/autocomplete.coffee