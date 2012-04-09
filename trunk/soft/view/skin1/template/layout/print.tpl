<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">

<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta name="author" content="" />

</head>
<style>
/* 
   Reset
------------------------------------------------------------------- */
html,body,div,span,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,code,del,dfn,em,img,q,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,textarea,input,select
	{
	margin: 0;
	padding: 0;
	border: 0;
	font-weight: inherit;
	font-style: inherit;
	font-size: 100%;
	font-family: inherit;
	vertical-align: baseline;
}

table {
	border-collapse: collapse;
	border-spacing: 0;
}

caption,th,td {
	font-weight: normal;
}

table,td,th {
	vertical-align: middle;
}

blockquote:before,blockquote:after,q:before,q:after {
	content: "";
}

blockquote,q {
	quotes: "" "";
}

a img {
	border: none;
}

:focus {
	outline: 0;
}

/* 
   General 
------------------------------------------------------------------- */
html {
	height: 100%;
	padding-bottom: 1px; /* force scrollbars */
}

body {
	background: #FFF;
	color: #444;
	font: normal 75% sans-serif;
	line-height: 1.5;
}

/* 
   Typography 
------------------------------------------------------------------- */
	/* Headings */
h1,h2,h3,h4,h5,h6 {
	color: #444;
	font-weight: normal;
	line-height: 1;
	margin-bottom: 0.3em;
}

h4,h5,h6 {
	font-weight: bold;
}

h1 {
	font-size: 2.6em;
}

h2 {
	font-size: 2em;
}

h3 {
	font-size: 1.5em;
}

h4 {
	font-size: 1.25em;
}

h5 {
	font-size: 1.1em;
}

h6 {
	font-size: 1em;
}

h1 img,h2 img,h3 img,h4 img,h5 img,h6 img {
	margin: 0;
}

/* Links */
a:focus,a:hover {
	color: #039;
}

a {
	color: #456;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

a.feed {
	background: url('img/icon-feed.gif') no-repeat left center;
	padding-left: 18px;
}

a.more {
	color: #579;
	font-weight: bold;
}

a.more:hover {
	color: #234;
}

/* Text elements */
p {
	margin-bottom: 1em;
}

abbr,acronym {
	border-bottom: 1px dotted #666;
}

address {
	margin-bottom: 1.5em;
}

blockquote {
	margin: 1.5em;
}

del,blockquote {
	color: #666;
}

em,dfn,blockquote,address {
	font-style: italic;
}

strong,dfn {
	font-weight: bold;
}

sup,sub {
	line-height: 0;
}

pre {
	margin: 1.5em 0;
	white-space: pre;
}

pre,code,tt {
	font: 1em monospace;
	line-height: 1.5;
}

/* Lists */
li ul,li ol {
	margin-left: 1.5em;
}

ul,ol {
	margin: 0 0 1.5em 1.5em;
}

ul {
	list-style-type: disc;
}

ol {
	list-style-type: decimal;
	margin-left: 1.9em;
}

dl {
	margin: 0 0 1.5em 0;
}

dl dt {
	font-weight: bold;
}

dd {
	margin-left: 1.5em;
}

/* Special lists */
ul.plain-list li,ul.nice-list li,ul.tabbed li {
	list-style: none;
	margin-top: 0;
}

ul.tabbed {
	display: inline;
	margin: 0;
}

ul.tabbed li {
	float: left;
}

ul.plain-list {
	margin: 0;
}

ul.nice-list {
	margin-left: 0;
}

ul.nice-list li {
	border-top: 1px solid #EEE;
	list-style: none;
	padding: 4px 0;
}

ul.nice-list li:first-child {
	border-top: none;
}

ul.nice-list li .right {
	color: #999;
}

/* Tables */
table {
	margin-bottom: 1.4em;
	width: 100%;
}

th {
	font-weight: bold;
}

thead th {
	background: #C3D9FF;
}

th,td,caption {
	padding: 4px 10px 4px 5px;
}

tr.even td {
	background: #F2F6FA;
}

tfoot {
	font-style: italic;
}

caption {
	background: #EEE;
}

table.data-table {
	border: 1px solid #CCB;
	margin-bottom: 2em;
	width: 100%;
}

table.data-table th {
	background: #F0F0F0;
	border: 1px solid #DDD;
	color: #555;
	text-align: left;
}

table.data-table tr {
	border-bottom: 1px solid #DDD;
	background: #FFF;
}

table.data-table td,table th { /*padding: 10px;*/
	
}

table.data-table td {
	border: 1px solid #DDD;
}

table.data-table tr.even td {
	background: #FFFFFF;
	font-weight: bold
}

/* Misc classes */
.small {
	font-size: 0.9em;
}

.smaller {
	font-size: 0.8em;
}

.smallest {
	font-size: 0.7em;
}

.large {
	font-size: 1.15em;
}

.larger {
	font-size: 1.25em;
}

.largest {
	font-size: 1.35em;
}

.hidden {
	display: none;
}

.quiet,.quiet a {
	color: #999;
}

.loud,.loud a {
	color: #000;
}

.highlight,.highlight a {
	background: #ff0;
}

.text-left {
	text-align: left;
}

.text-right {
	text-align: right;
}

.text-center {
	text-align: center;
}

.text-separator {
	padding: 0 5px;
}

.error,.notice,.success {
	border: 1px solid #DDD;
	margin-bottom: 1em;
	padding: 0.6em 0.8em;
}

.error {
	background: #FBE3E4;
	color: #8A1F11;
	border-color: #FBC2C4;
}

.error a {
	color: #8A1F11;
}

.notice {
	background: #FFF6BF;
	color: #514721;
	border-color: #FFD324;
}

.notice a {
	color: #514721;
}

.success {
	background: #E6EFC2;
	color: #264409;
	border-color: #C6D880;
}

.success a {
	color: #264409;
}

/* Labels */
.label {
	border-left-style: solid;
	border-left-width: 4px;
	margin-bottom: 0.2em;
	padding-left: 10px;
}

.label-blue {
	border-left-color: #55AADA;
}

.label-green {
	border-left-color: #B7D897;
}

.label-orange {
	border-left-color: #FA8F6F;
}

/* 
   Forms 
------------------------------------------------------------------- */
label {
	cursor: pointer;
	font-weight: bold;
}

label.checkbox,label.radio {
	font-weight: normal;
}

legend {
	font-weight: bold;
	font-size: 1.2em;
}

textarea {
	overflow: auto;
}

input.text,textarea,select {
	background: #FCFCFC;
	border: 1px inset #AAA;
	margin: 0.5em 0;
	padding: 4px 5px;
}

input.text:focus,textarea:focus,select:focus {
	background: #FFFFF5;
}

input.button {
	background: #DDD;
	border: 1px outset #AAA;
	padding: 4px 5px;
	cursor: pointer;
}

input.button:active {
	border-style: inset;
}

/* Specific */
form .required {
	font-weight: bold;
}

.form-error {
	border-color: #F00;
}

.form-row {
	padding: 5px 0;
}

.form-row-submit {
	border-top: 1px solid #DDD;
	padding: 8px 0 10px 76px;
	margin-top: 10px;
}

.legend {
	background: #F0FAF0;
	border: 1px solid #D6DFD6;
	font-size: 1.5em;
	margin: 0;
	padding: 8px 14px;
}

.form-property,.form-value {
	float: left;
}

.form-property {
	padding-top: 8px;
	text-align: right;
	width: 60px;
}

.form-value {
	padding-left: 16px;
}

.form-error {
	border-color: #F00;
}

textarea {
	width: 450px;
	height: 200px
}

td textarea {
	width: 100px;
	height: 50px;
}

/* 
   Alignment 
------------------------------------------------------------------- */
	/* General */
.center,.aligncenter {
	display: block;
	margin-left: auto;
	margin-right: auto;
}

/* Images */
img.bordered,img.alignleft,img.alignright,img.aligncenter {
	background-color: #FFF;
	border: 1px solid #DDD;
	padding: 3px;
}

img.alignleft,img.left {
	margin: 0 1.5em 1em 0;
}

img.alignright,img.right {
	margin: 0 0 1em 1.5em;
}

/* Floats */
.left,.alignleft {
	float: left;
}

.right,.alignright {
	float: right;
}

.clear,.clearer {
	clear: both;
}

.clearer {
	display: block;
	font-size: 0;
	line-height: 0;
	height: 0;
}

/* 
   Separators 
------------------------------------------------------------------- */
.content-separator,.archive-separator {
	background: #E5E5E5;
	clear: both;
	color: #FFE;
	display: block;
	font-size: 0;
	line-height: 0;
	height: 1px;
}

.content-separator {
	margin: 32px 0;
}

.archive-separator {
	margin-bottom: 20px;
}

/* 
   Posts 
------------------------------------------------------------------- */
.post {
	margin-bottom: 20px;
}

.post img.left,.post img.right {
	margin-bottom: 0;
}

.post-date {
	color: #777;
	margin: 2px 0 10px;
}

.post-date a {
	color: #444;
}

.post-meta a {
	color: #345;
}

.post-meta a:hover {
	color: #001;
}

.post-body {
	font-size: 1.1em;
}

.post-body a {
	color: #039;
}

.post-body a:hover {
	color: #039;
}

.post-body img.left,.post-body img.right {
	margin-bottom: 1em;
}

/* Archives */
.archive-pagination {
	color: #777;
	padding: 10px 0;
}

.archive-pagination-top {
	border-bottom: 2px solid #DDD;
	margin-bottom: 24px;
}

.archive-pagination-bottom {
	border-top: 2px solid #DDD;
	margin-top: 24px;
}

.archive-post-date {
	background: #F5F5F5;
	border-bottom: 1px solid #C5C5C5;
	border-right: 1px solid #CFCFCF;
	float: left;
	margin-right: 12px;
	padding: 2px 0 5px;
	text-align: center;
	width: 46px;
}

.archive-post-title .post-date {
	margin: 0;
}

.archive-post-title {
	padding-top: 4px;
}

.archive-post-day {
	font: normal 1.6em Georgia, serif;
}

/* 
   Comments 
------------------------------------------------------------------- */
.comment-input-text textarea {
	width: 80%;
}

/* Comment list */
.comment-list-wrapper {
	background: #F6F6F6;
	margin: 10px 0 0;
	padding: 5px 12px 10px 7px;
}

.comment-list {
	margin: 0;
	padding: 0;
}

.comment-list li {
	list-style: none;
}

.comment-list ul {
	margin-bottom: 0;
}

.comment-profile-wrapper {
	text-align: center;
	width: 105px;
}

.comment-gravatar {
	margin-bottom: 3px;
}

.comment-content-wrapper {
	float: right;
	width: 481px;
}

.comment-parent,.comment-single {
	margin-top: 15px;
}

.comment-list ul.children,#comments #respond ul {
	border-left: 1px solid #CCC;
	margin: 0 0 0 130px;
}

.comment-list ul.children ul.children {
	margin-left: 15px;
}

.comment-list ul.children li {
	background: url('img/comment-reply.gif') no-repeat left top;
	margin: 0;
	padding: 10px 0 0 15px;
}

.comment-body {
	background: #FFF;
	border: 1px solid #DDD;
	padding: 10px 12px 0;
}

.comment-list ul.children .comment-body {
	background: #FCFCFC;
}

.comment-author {
	padding-top: 2px;
}

.comment-text p {
	margin-bottom: 0.8em;
}

.comment .post-date,.comment-author {
	font-size: 0.9em;
}

.comment .post-date .right a {
	color: #BBB;
}

.comment .post-date .right a:hover {
	color: #234;
}

.comment-arrow {
	background: url('img/comment-arrow.gif') no-repeat left top;
	display: block;
	float: left;
	height: 45px;
	margin: 3px 0 -45px -41px;
	position: absolute;
	width: 29px;
}

/* Respond */
#respond li {
	list-style: none;
}

#respond {
	background: #F6F6F6;
	padding: 10px 12px;
}

#respond ul {
	margin: 0;
}

#respond .legend {
	margin-bottom: 10px;
}

#comments #respond {
	padding: 0;
}

#comments #respond .legend {
	border-bottom: 0;
	margin-bottom: 0;
}

#comments #respond ul {
	background: url('img/comment-reply.gif') no-repeat left top;
	padding: 10px 0 0 15px;
}

#comments ul.children #respond ul {
	margin-left: 30px;
	padding: 0;
}

#comments #respond .comment-profile-wrapper,#comments #respond .comment-arrow
	{
	display: none;
}

#comments #respond .comment-body {
	background: #FFF;
}

#comments #respond .comment-content-wrapper {
	float: none;
	width: 100%;
}

/* 
   Layout 
------------------------------------------------------------------- */
	/* Common */
#top,#sub-nav {
	border-bottom: 1px solid #DDD;
}

/* Wrapper */
#site-wrapper {
	margin: 0 auto;
}

/* Header */
#header {
	padding-top: 10px;
	position: relative
}

/* Top */
#top {
	padding-bottom: 15px;
	left: 50%;
}

/* Logo */
#logo {
	border-left: 1px solid #DDD;
	margin: 0px 20px;
	padding-left: 5px;
}

#logo img {
	
}

#weblogo {
	border-right: 1px solid #DDD;
	margin: 0px 20px;
}

/* Splash */
#splash {
	padding-top: 32px;
}

/* Navigation */
.navigation a {
	color: #888;
	text-decoration: none;
}

.navigation a:hover {
	color: #002;
}

.navigation li.current-tab a {
	color: #222;
}

#main-nav li:first-child,#sub-nav li:first-child {
	margin-left: 0;
}

/* Main navigation */
#main-nav {
	padding-top: 54px;
}

#main-nav li {
	margin: 0 1.5em;
}

#main-nav a {
	font-size: 1.8em;
	line-height: 2em;
	padding-bottom: 2px;
}

#main-nav li.current-tab a {
	color: #333;
}

#main-nav a:hover {
	color: #002;
}

#main-nav li.current-tab a {
	border-bottom: 2px solid #94CC5F;
}

/* Subnav */
#sub-nav {
	border-bottom: 1px solid #DDD;
	padding: 12px 0;
}

#sub-nav a {
	font-size: 1.2em;
	text-decoration: none;
}

#sub-nav li {
	margin: 0 1em;
}

#sub-nav li.current-tab a {
	font-weight: bold;
}

/* Main */
.main {
	margin: 24px 0;
}

.main#main-two-columns {
	
}

.main#main-two-columns-left {
	
}

.main#main-two-columns #main-content,.main#main-two-columns-left #main-content
	{
	width: 75%;
	border: 1px solid #F2F2F2;
	margin-right: 10px
}

/* Sidebar */
#sidebar {
	width: 22%;
	border: 1px solid #F2F2F2
}

/* Columns */
.col2 {
	width: 46%;
}

.col3,.col3-mid {
	width: 31%;
}

.col3-mid {
	margin-left: 3%;
}

/* Sections */
.section {
	margin-bottom: 24px;
}

.section-title {
	background-color: #F6F6F6;
	border-top: 2px solid #DDD;
	color: #999999;
	font: bold 1.2em sans-serif;
	margin-bottom: 16px;
	padding: 7px 10px 6px;
}

.padding1 {
	padding: 0px 10px 10px 10px;
}

#sidebar .section-title {
	margin-bottom: 8px;
}

/* Footer */
#footer {
	border-top: 1px solid #DDD;
	color: #777;
	padding: 16px 0 4px;
}

#footer-center {
	width: 500px;
	margin: 0 auto
}

#footer p {
	margin-bottom: 0.4em;
}

#footer .text-separator {
	padding: 0 3px;
	color: #BBB;
}

#footer a:hover {
	color: #000;
}
</style>

<body>

<div id="site-wrapper">

<div id="header"><?php echo $header?></div>

<div class="main">


<div id="main-content"><?php echo $content?></div>

<div class="clearer">&nbsp;</div>


</div>

<div id="footer"><?php echo $footer?></div>

</div>

</body>

</html>
