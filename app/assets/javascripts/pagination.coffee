$ ->
  if $('.pagination').length && $('#tutorials').length
    $(window).scroll ->
      url = $('.pagination .next a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text('Загрузка статей...')
        $.getScript(url)
    $(window).scroll()