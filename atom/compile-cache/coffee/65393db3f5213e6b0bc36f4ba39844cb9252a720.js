(function() {
  var $, EditorView, Keys, SelectListView, SimpleSelectListView, _, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  _ref = require("atom"), $ = _ref.$, SelectListView = _ref.SelectListView, EditorView = _ref.EditorView;

  _ = require("underscore-plus");

  Keys = {
    Escape: 27,
    Enter: 13,
    Tab: 9
  };

  SimpleSelectListView = (function(_super) {
    __extends(SimpleSelectListView, _super);

    function SimpleSelectListView() {
      return SimpleSelectListView.__super__.constructor.apply(this, arguments);
    }

    SimpleSelectListView.prototype.eventsAttached = false;

    SimpleSelectListView.prototype.maxItems = 10;

    SimpleSelectListView.content = function() {
      return this.div({
        "class": "select-list"
      }, (function(_this) {
        return function() {
          _this.input({
            "class": "fake-input",
            outlet: "fakeInput"
          });
          _this.div({
            "class": "error-message",
            outlet: "error"
          });
          _this.div({
            "class": "loading",
            outlet: "loadingArea"
          }, function() {
            _this.span({
              "class": "loading-message",
              outlet: "loading"
            });
            return _this.span({
              "class": "badge",
              outlet: "loadingBadge"
            });
          });
          return _this.ol({
            "class": "list-group",
            outlet: "list"
          });
        };
      })(this));
    };


    /*
     * Overrides default initialization
     */

    SimpleSelectListView.prototype.initialize = function() {
      this.on("core:move-up", (function(_this) {
        return function(e) {
          return _this.selectPreviousItemView();
        };
      })(this));
      return this.on("core:move-down", (function(_this) {
        return function() {
          return _this.selectNextItemView();
        };
      })(this));
    };

    SimpleSelectListView.prototype.setActive = function() {
      this.fakeInput.focus();
      if (!this.eventsAttached) {
        this.eventsAttached = true;
        return this.fakeInput.keydown((function(_this) {
          return function(e) {
            var _ref1;
            switch (e.keyCode) {
              case Keys.Enter:
              case Keys.Tab:
                _this.confirmSelection();
                break;
              case Keys.Escape:
                _this.cancel();
            }
            if (_ref1 = e.keyCode, __indexOf.call(_.values(Keys), _ref1) >= 0) {
              return false;
            }
          };
        })(this));
      }
    };

    SimpleSelectListView.prototype.populateList = function() {
      var i, item, itemView, _i, _ref1;
      if (this.items == null) {
        return;
      }
      this.list.empty();
      this.setError(null);
      for (i = _i = 0, _ref1 = Math.min(this.items.length, this.maxItems); 0 <= _ref1 ? _i < _ref1 : _i > _ref1; i = 0 <= _ref1 ? ++_i : --_i) {
        item = this.items[i];
        itemView = this.viewForItem(item);
        $(itemView).data("select-list-item", item);
        this.list.append(itemView);
      }
      return this.selectItemView(this.list.find("li:first"));
    };

    SimpleSelectListView.prototype.cancel = function() {
      this.list.empty();
      this.cancelling = true;
      this.detach();
      return this.cancelling = false;
    };

    return SimpleSelectListView;

  })(SelectListView);

  module.exports = SimpleSelectListView;

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLGtFQUFBO0lBQUE7O3lKQUFBOztBQUFBLEVBQUEsT0FBa0MsT0FBQSxDQUFRLE1BQVIsQ0FBbEMsRUFBQyxTQUFBLENBQUQsRUFBSSxzQkFBQSxjQUFKLEVBQW9CLGtCQUFBLFVBQXBCLENBQUE7O0FBQUEsRUFDQSxDQUFBLEdBQUksT0FBQSxDQUFRLGlCQUFSLENBREosQ0FBQTs7QUFBQSxFQUdBLElBQUEsR0FDRTtBQUFBLElBQUEsTUFBQSxFQUFRLEVBQVI7QUFBQSxJQUNBLEtBQUEsRUFBTyxFQURQO0FBQUEsSUFFQSxHQUFBLEVBQUssQ0FGTDtHQUpGLENBQUE7O0FBQUEsRUFRTTtBQUNKLDJDQUFBLENBQUE7Ozs7S0FBQTs7QUFBQSxtQ0FBQSxjQUFBLEdBQWdCLEtBQWhCLENBQUE7O0FBQUEsbUNBQ0EsUUFBQSxHQUFVLEVBRFYsQ0FBQTs7QUFBQSxJQUVBLG9CQUFDLENBQUEsT0FBRCxHQUFVLFNBQUEsR0FBQTthQUNSLElBQUMsQ0FBQSxHQUFELENBQUs7QUFBQSxRQUFBLE9BQUEsRUFBTyxhQUFQO09BQUwsRUFBMkIsQ0FBQSxTQUFBLEtBQUEsR0FBQTtlQUFBLFNBQUEsR0FBQTtBQUN6QixVQUFBLEtBQUMsQ0FBQSxLQUFELENBQU87QUFBQSxZQUFBLE9BQUEsRUFBTyxZQUFQO0FBQUEsWUFBcUIsTUFBQSxFQUFRLFdBQTdCO1dBQVAsQ0FBQSxDQUFBO0FBQUEsVUFDQSxLQUFDLENBQUEsR0FBRCxDQUFLO0FBQUEsWUFBQSxPQUFBLEVBQU8sZUFBUDtBQUFBLFlBQXdCLE1BQUEsRUFBUSxPQUFoQztXQUFMLENBREEsQ0FBQTtBQUFBLFVBRUEsS0FBQyxDQUFBLEdBQUQsQ0FBSztBQUFBLFlBQUEsT0FBQSxFQUFPLFNBQVA7QUFBQSxZQUFrQixNQUFBLEVBQVEsYUFB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
//# sourceURL=/Users/taichi.nakashima/.dotfiles/atom/packages/autocomplete-plus/lib/simple-select-list-view.coffee