<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_taisan">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="mataisan" name="mataisan" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tentaisan" name="tentaisan" class="text" value="" />
                <label>Nhóm</label>
					<select id="manhom" name="manhom">
                    	<option value=""></option>
                    	<?php foreach($nhomtaisan as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
                <label>Loại</label>
                <select id="loai" name="loai">
                    <option value=""></option>
                    <?php foreach($loaitaisan as $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                    <?php } ?>
                </select>
                <label>Kho</label>
                <select id="makho" name="makho">
                    <option value=""></option>
                    <?php foreach($kho as $val){ ?>
                    <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                    <?php } ?>
                </select>
                <br />
                <label>Tinh trang</label>
                <select id="tinhtrang" name="tinhtrang">
                    <option value=""></option>
                    <option value="chuachomuon">Chưa cho mượn</option>
                    <option value="chomuon">Cho mượn</option>
                    
                </select>
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/taisan'"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectTaiSan()">
                <input type="hidden" id="selecttaisan" name="selecttaisan" />
                <?php } ?>
                <?php if($dialog!=true){ ?>
                <?php if($this->user->checkPermission("quanlykho/taisan/sotaisan")==true){ ?>
            	<input class="button" value="Sổ tài sản" type="button" onclick="linkto('<?php echo $sotaisan?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/taisan/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/taisan/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Delete" onclick="deleteitem()"/> 
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listtaisan" class="sitemap treeindex">
                
            </div>
        	<?php echo $pager?>
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/taisan/delete", 
				$("#frm_taisan").serialize(), 
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
function loadData(url)
{
	var page = control.getParam('page');
	if(page!="")
		url+="&page="+page;
	$('#listtaisan').html(loading);
	$('#listtaisan').load(url);
}
function viewAll()
{
	url = "?route=quanlykho/taisan/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData(url);
}
$('.text').keyup(function(e) {
    searchForm();
});
$('select').change(function(e) {
    searchForm();
});
function searchForm()
{
	var url =  "";
	if($("#frm_taisan #mataisan").val() != "")
		url += "&mataisan=" + $("#frm_taisan #mataisan").val();
	
	if($("#frm_taisan #tentaisan").val() != "")
		url += "&tentaisan="+ $("#frm_taisan #tentaisan").val();
	if($("#frm_taisan #manhom").val() != "")
		url += "&manhom=" + $("#frm_taisan #manhom").val();
	if($("#frm_taisan #loai").val() != "")
		url += "&loai="+ $("#frm_taisan #loai").val();
	if($("#frm_taisan #makho").val() != "")
		url += "&makho=" + $("#frm_taisan #makho").val();
	if($("#frm_taisan #tinhtrang").val() != "")
		url += "&tinhtrang=" + $("#frm_taisan #tinhtrang").val();
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData("?route=quanlykho/taisan/getList"+url);
}


</script>