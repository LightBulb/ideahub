(function(W, D){
  var div, h1, h2, h3, p, a, li, span, textarea, button, dom, $el, sticky, App;
  div = React.createFactory('div');
  h1 = React.createFactory('h1');
  h2 = React.createFactory('h2');
  h3 = React.createFactory('h3');
  p = React.createFactory('p');
  a = React.createFactory('a');
  li = React.createFactory('li');
  span = React.createFactory('span');
  textarea = React.createFactory('textarea');
  button = React.createFactory('button');
  dom = React.findDOMNode;
  $el = React.createElement;
  sticky = function(){
    var self, header, hasScrolled;
    $('.wrapper').addClass('sticky-enabled');
    self = this;
    header = $('.header.header-logged-in');
    self.lastScrollTop = 0;
    self.delta = 5;
    self.navbarHeight = header.outerHeight();
    self.didScroll = false;
    $(W).scroll(function(event){
      self.didScroll = true;
      return setInterval(function(){
        if (self.didScroll) {
          hasScrolled();
          return self.didScroll = false;
        }
      }, 250);
    });
    return hasScrolled = function(){
      var st;
      st = $(W).scrollTop();
      if (Math.abs(self.lastScrollTop - st) <= self.delta) {
        return;
      }
      if (st > self.lastScrollTop && st > self.navbarHeight) {
        header.removeClass('nav-down').addClass('nav-up');
      } else if (st + $(W).height() < $(D).height()) {
        header.removeClass('nav-up').addClass('nav-down');
      }
      return self.lastScrollTop = st;
    };
  };
  sticky();
  App = (function(){
    App.displayName = 'App';
    var prototype = App.prototype, constructor = App;
    App.init = function(){
      var ideahubAccessToken, TweetboxOverride, IdeaNav, Pen, TweetBox;
      ideahubAccessToken = store.get('ideahub-access-token');
      TweetboxOverride = ideahubAccessToken
        ? ''
        : React.createClass({
          render: function(){
            return div({
              className: 'tweetbox-overlay'
            }, div({
              className: 'tweetbox-override'
            }), div({
              className: 'tweetbox-guest'
            }, a({
              className: 'btn btn-sm',
              href: 'https://ideahub.avosapps.com/api/github_login'
            }, span({
              className: 'octicon octicon-octoface'
            }), ' Sign in with GitHub'), ' | ', a({
              className: 'btn btn-sm',
              href: '#'
            }, span({
              className: 'octicon octicon-gist-secret'
            }), ' Guest')));
          }
        });
      $('.github-jobs-promotion').remove();
      $('#jobs_info_tip').remove();
      $('.dashboard-sidebar').prepend('<div class="tweetbox"></div>');
      $('#user-links').prepend('<li class="header-nav-item ideahub-pen"></li>');
      $('.header-nav.left').append('<li class="header-nav-item ideahub-idea-nav"></li>');
      IdeaNav = React.createClass({
        render: function(){
          return a({
            className: 'header-nav-link',
            href: '#'
          }, 'Ideas');
        }
      });
      Pen = React.createClass({
        handleClick: function(){
          if ($('.tweetboxContent')) {
            return $('.tweetboxContent').focus();
          }
        },
        render: function(){
          return a({
            href: '#',
            className: 'header-nav-link tooltipped tooltipped-s',
            onClick: this.handleClick,
            'aria-label': 'Compose some idea'
          }, span({
            className: 'octicon octicon-pencil'
          }));
        }
      });
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
            className: 'boxed-group tweetbox-boxed'
          }, $el(TweetboxOverride), h3(null, 'Any dev ideas?'), div({
            className: 'boxed-group-inner tweetbox-main'
          }, textarea({
            className: 'input-contrast tweetboxContent',
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
      React.render($el(Pen), D.querySelector('.ideahub-pen'));
      React.render($el(IdeaNav), D.querySelector('.ideahub-idea-nav'));
      return React.render($el(TweetBox), D.querySelector('.tweetbox'));
    };
    function App(){}
    return App;
  }());
  return App.init();
})(window, document);