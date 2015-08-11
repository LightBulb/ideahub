((W, D) ->

  # define factory
  div = React.create-factory \div
  h1 = React.create-factory \h1
  h2 = React.create-factory \h2
  h3 = React.create-factory \h3
  p = React.create-factory \p
  span = React.create-factory \span
  textarea = React.create-factory \textarea
  button = React.create-factory \button

  dom = React.findDOMNode

  class App
    @init = ->
      $('.github-jobs-promotion').remove!
      $('#jobs_info_tip').remove!
      $('.dashboard-sidebar').prepend '<div class="tweetbox"></div>'
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
                class-name: 'input-contrast'
                onChange: @handle-change
                ref: 'tweetboxContent'
              div do
                class-name: \form-actions
                button do
                  class-name: 'btn btn-primary btn-sm'
                  disabled: if @state.tweetbox-content.length > 0 then '' else 'disabled'
                  \Send


      React.render React.create-element(TweetBox), D.querySelector('.tweetbox')




  App.init!


) window, document