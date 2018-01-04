CKEDITOR.editorConfig = function (config) {
    config.extraPlugins = 'imgur';
    // Get your client-id from https://api.imgur.com/oauth2/addclient
    config.imgurClientID = 'c4608d4ccf2fd2e';
    config.toolbar_mini = [
        [],
      ];
    config.toolbar = "mini";
    config.autoParagraph = false;
    config.allowedContent = true
};