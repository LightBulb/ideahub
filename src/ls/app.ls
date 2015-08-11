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
            onClick: @handleClick
            'aria-label': 'Compose some idea'
            span do
              class-name: 'octicon octicon-pencil'


      TweetBox = React.create-class do
        getInitialState: ->
          do
            tweetbox-content: ''
        handle-change: ->
          el = @refs.tweetbox-content
          content = dom(el).value
          @setState do
            tweetbox-content: content 
        render: ->
          div do
            class-name: \boxed-group
            h3 null, 'Any dev ideas?'
            div do
              class-name: 'boxed-group-inner tweetbox-main'
              textarea do
                class-name: 'input-contrast tweetboxContent'
                onChange: @handle-change
                ref: 'tweetboxContent'
              div do
                class-name: \form-actions
                button do
                  class-name: 'btn btn-primary btn-sm'
                  disabled: if @state.tweetbox-content.length > 0 then '' else 'disabled'
                  \Send


      React.render React.create-element(Pen), D.querySelector('.ideahub-pen')
      React.render React.create-element(IdeaNav), D.querySelector('.ideahub-idea-nav')
      React.render React.create-element(TweetBox), D.querySelector('.tweetbox')
      # end init




  App.init!


) window, document