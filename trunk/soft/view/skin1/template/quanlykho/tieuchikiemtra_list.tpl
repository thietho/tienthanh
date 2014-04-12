<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_tieuchikiemtra">
        	<div id="ben-search">
            	<label>Loại</label>
                <select id="itemtype" name="itemtype">
                    <option value=""></option>
                    <?php foreach($this->document->dauvao as $key => $val){ ?>
                    <option value="<?php echo $key?>"><?php echo $val?></option>
                    <?php } ?>
                </select>
            	<label>Mã số</label>
                <input type="text" id="itemcode" name="itemcode" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="itemname" name="itemname" class="text" value="" />
                
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	
                <?php }else{ ?>
                
                
                
                <?php if($this->user->checkPermission("quanlykho/tieuchikiemtra/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>#page='+control.getParam('page',strurl))">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/tieuchikiemtra/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listitem" class="sitemap treeindex">
                
            </div>
        	
        
        </form>
        
    </div>
    
</div>
<script language="javascript">

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/tieuchikiemtra/delete", 
				$("#frm_tieuchikiemtra").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data)
						window.location.reload();
					}
				}
		);
	}
}
$(document).ready(function(e) {
    viewAll();
	
});

$('#frm_tieuchikiemtra .text').keyup(function(e) {
    searchForm();
});
$('#frm_tieuchikiemtra select').change(function(e) {
    searchForm();
});
function loadData(url)
{
	var page = control.getParam('page',strurl);
	if(page!="")
		url+="&page="+page;
	$('#listitem').html(loading);
	$('#listitem').load(url);
}
function viewAll()
{
	url = "?route=quanlykho/tieuchikiemtra/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_tieuchikiemtra #itemtype").val() != "")
		url += "&itemtype=" + $("#frm_tieuchikiemtra #itemtype").val();
	
	if($("#frm_tieuchikiemtra #itemcode").val() != "")
		url += "&itemcode="+ encodeURI($("#frm_tieuchikiemtra #itemcode").val());
	
	if($("#frm_tieuchikiemtra #itemname").val() != "")
		url += "&itemname="+ encodeURI($("#frm_tieuchikiemtra #itemname").val());
	
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData("?route=quanlykho/tieuchikiemtra/getList"+url);
}
function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>