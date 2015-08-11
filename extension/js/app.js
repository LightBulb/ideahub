(function(W, D){
  var div, h1, h2, h3, p, span, textarea, button, App;
  div = React.createFactory('div');
  h1 = React.createFactory('h1');
  h2 = React.createFactory('h2');
  h3 = React.createFactory('h3');
  p = React.createFactory('p');
  span = React.createFactory('span');
  textarea = React.createFactory('textarea');
  button = React.createFactory('button');
  App = (function(){
    App.displayName = 'App';
    var prototype = App.prototype, constructor = App;
    App.init = function(){
      var TweetBox;
      $('.github-jobs-promotion').remove();
      $('#jobs_info_tip').remove();
      $('.dashboard-sidebar').prepend('<div class="tweetbox"></div>');
      TweetBox = React.createClass({
        render: function(){
          return div({
            className: 'boxed-group'
          }, h3(null, 'Any dev ideas?'), div({
            className: 'boxed-group-inner tweetbox-main'
          }, textarea({
            className: 'input-contrast'
          }), div({
            className: 'form-actions'
          }, button({
            className: 'btn btn-primary btn-sm'
          }, 'Send'))));
        }
      });
      return React.render(React.createElement(TweetBox), D.querySelector('.tweetbox'));
    };
    function App(){}
    return App;
  }());
  return App.init();
})(window, document);