
UI.Base = {
  options: {},
  cont_pjax: '[data-pjax-container]',

  init: function(options) {
    var self = this;

    $.extend(self.options, options);

    $(self.cont_list + ' .filter-form').live('submit', function(e) {
      self.applyFilter();
      e.preventDefault();
    });
  },

  t: function(rec) {
    var self = this;
    return I18n.t(rec, { scope: self.i18n_scope });
  },

  form: function(item_id, url) {
    var self = this;

    $.ajax({
      url: url,
      type: 'GET',
      success: function(data) {
        self._form(data, item_id);
      }
    });
  },

  _form: function(data, item_id) {
    var self = this;

    self.cont_form = $("<div/>").html(data).attr({ "id" : "dialog_" + item_id });

    self.cont_form.dialog({
      title: (item_id != 0 ? self.t("title.edit") : self.t("title.new")),
      resizable: false,
      draggable: true,
      height: 'auto',
      width: 'auto',
      modal: true,
      closeOnEscape: false,
      open: function() {
        $(':input, a', self.cont_form).blur();
      },
      close: function() {
        self.cont_form.dialog("destroy").remove();
      }
    });
  },

  closeForm: function() {
    var self = this;

    self.cont_form.dialog("destroy").remove();
  },

  refreshList: function() {
    var self = this;

    $.pjax({
      url: document.location.href,
      container: self.cont_pjax,
      push: false,
      scrollTo: false
    });
  },

  destroy: function(url) {
    var self = this;

    UI.Helpers.Dialogs.confirm({
      title: self.t("title.destroy"),
      text: I18n.t("common.messages.are_you_sure"),
      callback: function(){
        $.rails.handleRemote($('<a href="' + url + '" data-remote="true" data-method="DELETE"></a>'));
      }
    });

    return false;
  },

  destroySelected: function(e) {
    var self = this;

    var data = $(self.cont_list + ' .list-items [data-action="select"]').serialize();
    var url = self.url_destroy_selected + "?" + data;

    UI.Helpers.Dialogs.confirm({
      title: self.t("title.destroy_selected"),
      text: I18n.t("common.messages.are_you_sure"),
      callback: function(){
        $.rails.handleRemote($('<a href="' + url + '" data-method="DELETE"></a>'));
      }
    });

    return false;
  },

  applyFilter: function() {
    var self = this;

    var data = $(self.cont_list + ' .filter-form').serialize();
    $.pjax({
      url: self.url_list + '?' + data,
      container: self.cont_pjax
    });
  },

  resetFilter: function() {
    var self = this;

    $.pjax({
      url: self.url_list,
      container: self.cont_pjax
    });
  },

  redirect: function(url) {
    var self = this;

    $.pjax({
      url: url,
      container: self.cont_pjax
    });
  },

};
