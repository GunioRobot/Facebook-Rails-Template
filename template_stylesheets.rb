#----------------------------------------------------------------------------
# Compass
#----------------------------------------------------------------------------

file 'app/assets/stylesheets/reset.css.scss', <<-CODE
@import "compass/reset";
CODE

run 'rm app/assets/stylesheets/application.css'
file 'app/assets/stylesheets/application.css.scss', <<-CODE
//= require reset
//= require common
@import "partials/lib";
CODE

file 'app/assets/stylesheets/partials/_lib.css.scss', <<-CODE
@import "compass/utilities";
@import "compass/css3";
@import "blueprint";

// Colors
$link-color: #307eae;
$link-visited-color: #307eae;

$light-grey: #EFEFEF;
$medium-grey: #6F6F6F;
$dark-grey: #AFAFAF;

$very-light-blue: #E4EDF8;
$light-blue: #ECEFF5;
$medium-blue: #627AAD;
$dark-blue: #40539D;
CODE

file 'app/assets/stylesheets/common.css.scss', <<-CODE
@import "partials/lib";
@include blueprint-typography-defaults;
@include blueprint-form;

// Helpers
.left { float: left; }
.right { float: right; }
.center { text-align: center; }
.clear { clear: both; }
.strong, b { font-weight: bold; }
.italic, i { font-style: italic; }

body {
  @include blueprint-typography-body(12px);
  font-family: "lucida grande",tahoma,verdana,arial,sans-serif;
}

p { margin: 0 0 10px; }

form, .form {
  div.input { margin: 12px 0; @include clearfix; }
  div.radio, div.checkbox { margin-top: 2px; }

  div.buttons {
    margin-top: 15px;
  }
  
  input, textarea { margin:0.5em 0; }
  
  input[type='text'], textarea {
    width: 400px;
    @include border-radius(4px)
  }

  textarea { height: 100px; font-size: 11px; font-family: "lucida grande",tahoma,verdana,arial,sans-serif; }
  
  label {
    display: block;
    &.checkbox, &.radio {
      font-weight: normal;
      display: inline;
    }
  }

  #errorExplanation {
    width: 450px;
    border: 1px solid $error_border_color;
    @include border-radius(4px);
    padding: 7px;
    margin: 10px 0px;
    background-color: $error_bg_color;
    ul{
      margin-bottom: 0;
      > li { padding-bottom: 5px; }
    }
  }
  .error { display: none; }

  .field_with_errors {
    display: inline;
    label { color: $error_color; }
    input { border-color: $error_border_color; }
  }
}

.flash {
  @include border-radius(4px);
  text-align: center;
  &.alert { @include error }
  &.notice { @include success }
}
CODE