var &&name&&Binding = new Shiny.InputBinding();

$.extend(&&name&&Binding, {
  find: function(scope) {
    return $(scope).find(".&&name&&");
  },
  initialize: function(el) {
  /*  var config = $(el);
    config.find('script[data-for="' + Shiny.$escape(inputId) + '"]');
    config = JSON.parse(config.html());*/

  },
  getId: function(el) {
    return el.id;
  },
  getValue: function(el) {
   /*console.log($(el));
     return $(el).val(); */
  },
  setValue: function(el, value) {
    // $(el).val(value);

  },
  receiveMessage: function(el, data) {
   /*  console.log(data);
  if (data.hasOwnProperty('value')) {
    this.setValue(el, data.value);
      }*/

  // other parameters to update...
  },
    getState: function (el) {
    // Store options in an array of objects, each with with value and label
    },
  getRatePolicy: function()
  /*  return {
      policy: "debounce",
      delay: 250
    };*/
  },
  subscribe: function(el, callback) {
    /*register shiny events
    var inputId = el.id;
    $(el).on('click', function(e) {
      callback();
    });

    $(el).on('change.&&name&&Binding',
    function(e) {
      callback();
    });*/

  },
  unsubscribe: function(el) {

    $(el).off('.&&name&&Binding');
  }
});

Shiny.inputBindings.register(&&name&&Binding, "shiny.&&name&&");
