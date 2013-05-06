winapi = require'winapi_init'
setfenv(1, require'winapi_init')
require'winapi_messageloop'
require'winapi_menuclass'
require'winapi_messagebox'
require'winapi_htmlayoutclass'

html_text = [[
<html>
<head>
<style> 

  table 
  { 
      border:1px solid #bdbccc; 
      overflow: auto;
      width:100%%;
      height:100%%;
      behavior:grid;
      background-color:white;
  }
  @media print  
  {
    /* on printer we don't need overflow and behavior */
    table 
    { 
      overflow: none;
      behavior: none;
    }
  }
  table th 
  { 
    color: white;
    font-family:"Century Gothic","Verdana"; 
    font-size:10pt; 
    border:none;
    padding:4px; 
    background-color:#DDD; 
    background-image:url(header.png);
    background-repeat:expand stretch-left stretch-right stretch-middle;
	  background-position:3px 3px 3px 3px;
  }
  table th:hover 
  { 
    color: #ffe598;
    transition:blend;
    background-image:url(header-hover.png);
  }
  
  table tr { context-menu:selector(menu#row-menu); } 
  
  table tr:nth-child(odd) { background-color:white; } /* each odd row */
  table tr:nth-child(even) { background-color:#F4F3F9 white white #F4F3F9; } /* each even row */
  
  /*table[fixedrows="2"] > tr:nth-child(1),
  table[fixedrows="2"] > tr:nth-child(2)  
    { background-color:transparent; } */

  
  table tr:current /* current row */ 
  { 
    background-color:#bdbccc; 
    outline:1px solid red -1px;
    color:white;
  } 
  
  table td 
  { 
    padding:2px; 
    font-family:"Verdana"; 
	  font-size:9pt;  
  }
  table td:hover 
  { 
    background-color:yellow;
  }  
  
  table td:nth-child(1) { font-weight:bold; text-align:center; width:10%%; } /* first column */
  table td:nth-child(2) { border-left:1px solid #bdbccc; color:#8380A0; width:10%%; } /* second column */
  table td:nth-child(3) /* last column */
  { 
     text-align:left;
     /*overflow:hidden;         three line below - ellipsis 
     text-overflow:ellipsis;
     white-space:nowrap; */
     width:80%%;
     border-left:1px solid #bdbccc;
  } 
  
  table tr:checked /* checked row */ 
  { 
    color:red;
  } 
  
  _service > popup 
  { 
    width:max-intrinsic; background-color:orange; 
    font: 8pt Verdana;
  } 
   
</style>
</head>

<body>

Letters in the Latin-1 Set:
<table fixedrows="1" cellspacing="0" style="margin:20px">
  <tr><th>Character<th>Entity<th>Description</th></tr>
  <tr><td>&Agrave;<td>&amp;Agrave;<td><font color="brown">capital</font> A <font color="green">with</font> grave = <font color="brown">capital</font> A grave</td></tr>
  <tr><td>&Aacute;<td>&amp;Aacute;<td><font color="brown">capital</font> A with acute</td></tr>
  <tr><td>&Acirc;<td>&amp;Acirc;<td><font color="brown">capital</font> A with circumflex</td></tr>
  <tr><td>&Atilde;<td>&amp;Atilde;<td><font color="brown">capital</font> A with tilde</td></tr>
  <tr><td>&Auml;<td>&amp;Auml;<td><font color="brown">capital</font> A with diaeresis</td></tr>
  <tr><td>&Aring;<td>&amp;Aring;<td><font color="brown">capital</font> A with ring above = <font color="brown">capital</font> A ring</td></tr>
  <tr><td>&AElig;<td>&amp;AElig;<td><font color="brown">capital</font> AE = <font color="brown">capital</font> ligature AE</td></tr>
  <tr><td>&Ccedil;<td>&amp;Ccedil;<td><font color="brown">capital</font> C with cedilla</td></tr>
  <tr><td>&Egrave;<td>&amp;Egrave;<td><font color="brown">capital</font> E with grave</td></tr>
  <tr><td>&Eacute;<td>&amp;Eacute;<td><font color="brown">capital</font> E with acute</td></tr>
  <tr><td>&Ecirc;<td>&amp;Ecirc;<td><font color="brown">capital</font> E with circumflex</td></tr>
  <tr><td>&Euml;<td>&amp;Euml;<td><font color="brown">capital</font> E with diaeresis</td></tr>
  <tr><td>&Igrave;<td>&amp;Igrave;<td><font color="brown">capital</font> I with grave</td></tr>
  <tr><td>&Iacute;<td>&amp;Iacute;<td><font color="brown">capital</font> I with acute</td></tr>
  <tr><td>&Icirc;<td>&amp;Icirc;<td><font color="brown">capital</font> I with circumflex</td></tr>
  <tr><td>&Iuml;<td>&amp;Iuml;<td><font color="brown">capital</font> I with diaeresis</td></tr>
  <tr><td>&ETH;<td>&amp;ETH;<td><font color="brown">capital</font> ETH</td></tr>
  <tr><td>&Ntilde;<td>&amp;Ntilde;<td><font color="brown">capital</font> N with tilde</td></tr>
  <tr><td>&Ograve;<td>&amp;Ograve;<td><font color="brown">capital</font> O with grave</td></tr>
  <tr><td>&Oacute;<td>&amp;Oacute;<td><font color="brown">capital</font> O with acute</td></tr>
  <tr><td>&Ocirc;<td>&amp;Ocirc;<td><font color="brown">capital</font> O with circumflex</td></tr>
  <tr><td>&Otilde;<td>&amp;Otilde;<td><font color="brown">capital</font> O with tilde</td></tr>
  <tr><td>&Ouml;<td>&amp;Ouml;<td><font color="brown">capital</font> O with diaeresis</td></tr>
  <tr><td>&times;<td>&amp;times;<td>multiplication sign</td></tr>
  <tr><td>&Oslash;<td>&amp;Oslash;<td><font color="brown">capital</font> O with stroke = <font color="brown">capital</font> O slash</td></tr>
  <tr><td>&Ugrave;<td>&amp;Ugrave;<td><font color="brown">capital</font> U with grave</td></tr>
  <tr><td>&Uacute;<td>&amp;Uacute;<td><font color="brown">capital</font> U with acute</td></tr>
  <tr><td>&Ucirc;<td>&amp;Ucirc;<td><font color="brown">capital</font> U with circumflex</td></tr>
  <tr><td>&Uuml;<td>&amp;Uuml;<td><font color="brown">capital</font> U with diaeresis</td></tr>
  <tr><td>&Yacute;<td>&amp;Yacute;<td><font color="brown">capital</font> Y with acute</td></tr>
  <tr><td>&THORN;<td>&amp;THORN;<td><font color="brown">capital</font> THORN</td></tr>
  <tr><td>&szlig;<td>&amp;szlig;<td>small sharp s = ess-zed</td></tr>
  <tr><td>&agrave;<td>&amp;agrave;<td>small a with grave = small a grave</td></tr>
  <tr><td>&aacute;<td>&amp;aacute;<td>small a with acute</td></tr>
  <tr><td>&acirc;<td>&amp;acirc;<td>small a with circumflex</td></tr>
  <tr><td>&atilde;<td>&amp;atilde;<td>small a with tilde</td></tr>
  <tr><td>&auml;<td>&amp;auml;<td>small a with diaeresis</td></tr>
  <tr><td>&aring;<td>&amp;aring;<td>small a with ring above = small a ring</td></tr>
  <tr><td>&aelig;<td>&amp;aelig;<td>small ae = small ligature ae</td></tr>
  <tr><td>&ccedil;<td>&amp;ccedil;<td>small c with cedilla</td></tr>
  <tr><td>&egrave;<td>&amp;egrave;<td>small e with grave</td></tr>
  <tr><td>&eacute;<td>&amp;eacute;<td>small e with acute</td></tr>
  <tr><td>&ecirc;<td>&amp;ecirc;<td>small e with circumflex</td></tr>
  <tr><td>&euml;<td>&amp;euml;<td>small e with diaeresis</td></tr>
  <tr><td>&igrave;<td>&amp;igrave;<td>small i with grave</td></tr>
  <tr><td>&iacute;<td>&amp;iacute;<td>small i with acute</td></tr>
  <tr><td>&icirc;<td>&amp;icirc;<td>small i with circumflex</td></tr>
  <tr><td>&iuml;<td>&amp;iuml;<td>small i with diaeresis</td></tr>
  <tr><td>&eth;<td>&amp;eth;<td>small eth</td></tr>
  <tr><td>&ntilde;<td>&amp;ntilde;<td>small n with tilde</td></tr>
  <tr><td>&ograve;<td>&amp;ograve;<td>small o with grave</td></tr>
  <tr><td>&oacute;<td>&amp;oacute;<td>small o with acute</td></tr>
  <tr><td>&ocirc;<td>&amp;ocirc;<td>small o with circumflex</td></tr>
  <tr><td>&otilde;<td>&amp;otilde;<td>small o with tilde</td></tr>
  <tr><td>&ouml;<td>&amp;ouml;<td>small o with diaeresis</td></tr>
  <tr><td>&divide;<td>&amp;divide;<td>division sign</td></tr>
  <tr><td>&oslash;<td>&amp;oslash;<td>small o with stroke = small o slash</td></tr>
  <tr><td>&ugrave;<td>&amp;ugrave;<td>small u with grave</td></tr>
  <tr><td>&uacute;<td>&amp;uacute;<td>small u with acute</td></tr>
  <tr><td>&ucirc;<td>&amp;ucirc;<td>small u with circumflex</td></tr>
  <tr><td>&uuml;<td>&amp;uuml;<td>small u with diaeresis</td></tr>
  <tr><td>&yacute;<td>&amp;yacute;<td>small y with acute</td></tr>
  <tr><td>&thorn;<td>&amp;thorn;<td>small thorn</td></tr>
  <tr><td>&yuml;<td>&amp;yuml;<td>small y with diaeresis</td></tr>
</table>

Multiselect grid, CTRL and SHIFT combinations, Ctrl-A<br/>
Symbol Entities in the Latin-1 Set:
<table fixedrows="2" cellspacing="0" style="margin:20px" multiple>
  <tr><th colspan=2>Representation<th rowspan=2>Description</th></tr>
  <tr><th>Character<th>Entity</tr>
  <tr><td>&nbsp;<td>&amp;nbsp;<td><a href="ss">AAAAAAAAAAAAAAAAAAAAA PATH AAAAAAAAAAABBBBBBBBBBBBBXCCCCCCCCCCCCCCCCCCCCSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS</a></td></tr>
  <tr><td>&iexcl;<td>&amp;iexcl;<td>inverted exclamation mark</td></tr>
  <tr><td>&cent;<td>&amp;cent;<td>cent sign</td></tr>
  <tr><td>&pound;<td>&amp;pound;<td>pound sign</td></tr>
  <tr><td>&curren;<td>&amp;curren;<td>currency sign</td></tr>
  <tr><td>&yen;<td>&amp;yen;<td>yen sign = yuan sign</td></tr>
  <tr><td>&brvbar;<td>&amp;brvbar;<td>broken bar = broken vertical bar</td></tr>
  <tr><td>&sect;<td>&amp;sect;<td>section sign</td></tr>
  <tr><td>&uml;<td>&amp;uml;<td>diaeresis = spacing diaeresis</td></tr>
  <tr><td>&copy;<td>&amp;copy;<td>copyright sign</td></tr>
  <tr><td>&ordf;<td>&amp;ordf;<td>feminine ordinal indicator</td></tr>
  <tr><td>&laquo;<td>&amp;laquo;<td>left-pointing double angle quotation mark = left pointing guillemet</td></tr>
  <tr><td>&not;<td>&amp;not;<td>not sign</td></tr>
  <tr><td>&shy;<td>&amp;shy;<td>soft hyphen = discretionary hyphen</td></tr>
  <tr><td>&reg;<td>&amp;reg;<td>registered sign = registered trade mark sign</td></tr>
  <tr><td>&macr;<td>&amp;macr;<td>macron = spacing macron = overline = APL overbar</td></tr>
  <tr><td>&deg;<td>&amp;deg;<td>degree sign</td></tr>
  <tr><td>&plusmn;<td>&amp;plusmn;<td>plus-minus sign = plus-or-minus sign</td></tr>
  <tr><td>&sup2;<td>&amp;sup2;<td>superscript two = superscript digit two = squared</td></tr>
  <tr><td>&sup3;<td>&amp;sup3;<td>superscript three = superscript digit three = cubed</td></tr>
  <tr><td>&acute;<td>&amp;acute;<td>acute accent = spacing acute</td></tr>
  <tr><td>&micro;<td>&amp;micro;<td>micro sign</td></tr>
  <tr><td>&para;<td>&amp;para;<td>pilcrow sign = paragraph sign</td></tr>
  <tr><td>&middot;<td>&amp;middot;<td>middle dot = Georgian comma = Greek middle dot</td></tr>
  <tr><td>&cedil;<td>&amp;cedil;<td>cedilla = spacing cedilla</td></tr>
  <tr><td>&sup1;<td>&amp;sup1;<td>superscript one = superscript digit one</td></tr>
  <tr><td>&ordm;<td>&amp;ordm;<td>masculine ordinal indicator</td></tr>
  <tr><td>&raquo;<td>&amp;raquo;<td>right-pointing double angle quotation mark = right pointing guillemet</td></tr>
  <tr><td>&frac14;<td>&amp;frac14;<td>vulgar fraction one quarter = fraction one quarter</td></tr>
  <tr><td>&frac12;<td>&amp;frac12;<td>vulgar fraction one half = fraction one half</td></tr>
  <tr><td>&frac34;<td>&amp;frac34;<td>vulgar fraction three quarters = fraction three quarters</td></tr>
  <tr><td>&iquest;<td>&amp;iquest;<td>inverted question mark = turned question mark</td></tr>
</table>

  <menu.popup id="row-menu">
      <li id="i1">First item</li>
      <li id="i2">Second item</li>
      <li id="i3">Third item</li>
      <li id="i4">Fourth item</li>
  </menu>
  
  <a href="#">Link test</a>

</body>

</html>

]]

function maximize()
	winapi.MessageBox("HI")
end


local main = winapi.Window{
   title = 'Menu Example',
   w = 600, h = 400,
   autoquit = true,
   on_resizinsg = maximize
}


local file_submenu = Menu{
		items = {
			{
			text = 'E&xit', on_click = function() main:close() end
			},
			{
			text = 'H&i', on_click = function() winapi.MessageBox(ffi.string(htmlayout:ClassNameA())) end
			},
			{
			text = 'L&oad', on_click = function() htmlayout:LoadHtml(html_text) end
			},
		}
	}
	


local mainm = MenuBar{ 
	items = {
		{
		 text = '&File', 
		 submenu = file_submenu
		},
		
		{text = '&Help'},
	},
}

main.menu = mainm
htmlayout = HTMLayout
			{
					parent = main, 
					x = 10, 
					y = 10, 
					case = 'upper', 
					limit = 8,
					anchors = {
					left = true,
					top = true,
					right = true,
					bottom = true
					}
			}



Window.maximize(htmlayout)


os.exit(MessageLoop())



