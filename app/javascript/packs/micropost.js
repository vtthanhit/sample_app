import I18n from "i18n-js/index.js.erb"
console.log(I18n.t("global.alert.image_max_size"))
$("#micropost_image").bind("change", function() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > Settings.image_megabytes_5) {
      alert(I18n.t("global.alert.image_max_size"));
    }
});
