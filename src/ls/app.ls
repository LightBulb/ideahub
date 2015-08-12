React = require \react
$ = require \jquery
store = require \store

((W, D) ->

  # define factory
  div = React.create-factory \div
  h1 = React.create-factory \h1
  h2 = React.create-factory \h2
  h3 = React.create-factory \h3
  p = React.create-factory \p
  a = React.create-factory \a
  li = React.create-factory \li
  span = React.create-factory \span
  textarea = React.create-factory \textarea
  button = React.create-factory \button

  dom = React.findDOMNode
  $el = React.create-element

  sticky = ->
    $('.wrapper').add-class 'sticky-enabled'
    self = @
    header = $('.header.header-logged-in')
    self.lastScrollTop = 0
    self.delta = 5
    self.navbarHeight = header.outerHeight!
    self.didScroll = false
    $(W).scroll (event) -> 
      self.didScroll = true
      setInterval ->
        if self.didScroll
          hasScrolled!
          self.didScroll = false
      , 250

    hasScrolled = ->
      st = $(W).scrollTop!
      # Make sure they scroll more than delta
      return if Math.abs(self.lastScrollTop - st) <= self.delta

      # If they scrolled down and are past the navbar, add class .nav-up.
      # This is necessary so you never see what is "behind" the navbar.
      if st > self.lastScrollTop and st > self.navbarHeight
        # Scroll Down
        header.remove-class('nav-down').add-class('nav-up')
      else if st + $(W).height! < $(D).height!
        # Scroll Up
        header.remove-class('nav-up').add-class('nav-down') 

      self.lastScrollTop = st
    

  sticky!

  class App
    @init = ->

      ideahub-access-token = store.get \ideahub-access-token
      #github-token-from-url = 

      TweetboxOverride = if ideahub-access-token then '' else React.create-class do
        handle-guest-click: ->
          # $('.tweetbox-overlay').remove!
          alert 'Guest mode not yet available!'
        render: ->
          div do
            class-name: 'tweetbox-overlay'
            div do
              class-name: 'tweetbox-override'
            div do
              class-name: 'tweetbox-guest'
              a do
                class-name: 'btn btn-sm'
                href: 'https://ideahub.avosapps.com/api/github_login'
                span do
                  class-name: 'octicon octicon-octoface'
                ' Sign in with GitHub'
              ' | '
              a do
                class-name: 'btn btn-sm'
                href: '#'
                on-click: @handle-guest-click
                span do
                  class-name: 'octicon octicon-gist-secret'
                ' Guest'

      
      $('.github-jobs-promotion').remove!
      $('#jobs_info_tip').remove!
      $('.dashboard-sidebar').prepend '<div class="tweetbox"></div>'
      $('#user-links').prepend '<li class="header-nav-item ideahub-pen"></li>'
      $('.header-nav.left').append '<li class="header-nav-item ideahub-idea-nav"></li>'

      IdeaNav = React.create-class do
        render: ->
          a do
            class-name: 'header-nav-link'
            href: '#'
            \Ideas

      Pen = React.create-class do
        handleClick: ->
          if $('.tweetboxContent') then $('.tweetboxContent').focus()
        render: ->
          a do
            href: '#'
            class-name: 'header-nav-link tooltipped tooltipped-s'
            on-click: @handleClick
            'aria-label': 'Compose some idea'
            span do
              class-name: 'octicon octicon-pencil'


      TweetBox = React.create-class do
        get-initial-state: ->
          do
            tweetbox-content: ''
        handle-change: ->
          el = @refs.tweetbox-content
          content = dom(el).value
          @setState do
            tweetbox-content: content 
        render: ->
          div do
            class-name: 'boxed-group tweetbox-boxed'
            $el TweetboxOverride
            h3 null, 'Any dev ideas?'
            div do
              class-name: 'boxed-group-inner tweetbox-main'
              textarea do
                class-name: 'input-contrast tweetboxContent'
                on-change: @handle-change
                ref: 'tweetboxContent'
              div do
                class-name: \form-actions
                button do
                  class-name: 'btn btn-primary btn-sm'
                  disabled: if @state.tweetbox-content.length > 0 then '' else 'disabled'
                  \Send


      React.render $el(Pen), D.querySelector('.ideahub-pen')
      React.render $el(IdeaNav), D.querySelector('.ideahub-idea-nav')
      React.render $el(TweetBox), D.querySelector('.tweetbox')
      # end init




  App.init!


) window, document