(function(W, D){
  var div, h1, h2, h3, p, span, textarea, button, dom, App;
  div = React.createFactory('div');
  h1 = React.createFactory('h1');
  h2 = React.createFactory('h2');
  h3 = React.createFactory('h3');
  p = React.createFactory('p');
  span = React.createFactory('span');
  textarea = React.createFactory('textarea');
  button = React.createFactory('button');
  dom = React.findDOMNode;
  App = (function(){
    App.displayName = 'App';
    var prototype = App.prototype, constructor = App;
    App.init = function(){
      var TweetBox;
      $('.github-jobs-promotion').remove();
      $('#jobs_info_tip').remove();
      $('.dashboard-sidebar').prepend('<div class="tweetbox"></div>');
      TweetBox = React.createClass({
        getInitialState: function(){
          return {
            tweetboxContent: ''
          };
        },
        handleChange: function(){
          var el, content;
          el = this.refs.tweetboxContent;
          content = dom(el).value;
          return this.setState({
            tweetboxContent: content
          });
        },
        render: function(){
          return div({
            className: 'boxed-group'
          }, h3(null, 'Any dev ideas?'), div({
            className: 'boxed-group-inner tweetbox-main'
          }, textarea({
            className: 'input-contrast',
            onChange: this.handleChange,
            ref: 'tweetboxContent'
          }), div({
            className: 'form-actions'
          }, button({
            className: 'btn btn-primary btn-sm',
            disabled: this.state.tweetboxContent.length > 0 ? '' : 'disabled'
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