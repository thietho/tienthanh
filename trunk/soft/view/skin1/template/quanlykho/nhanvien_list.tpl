<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_nhanvien">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="manhanvien" name="manhanvien" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="hoten" name="hoten" class="text" value="" />
                <label>Phòng ban</label>
                <select id="maphongban" name="maphongban">
                    <option value=""></option>
                    <?php foreach($phongbans as $val){ ?>
                    <option value="<?php echo $val['maphongban']?>"><?php echo $val['tenphongban']?></option>
                    <?php } ?>
                </select>
                <label>Chức vụ</label>
                <select id="machucvu" name="machucvu">
                    <option value=""></option>
                    <?php foreach($chucvus as $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                    <?php } ?>
                </select>
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
            <!-- end search -->
            
        	<div class="button right">
                <?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectNhanVien()">
                <input type="hidden" id="selectnhanvien" name="selectnhanvien" />
                <?php } ?>
                <?php if($dialog!=true){ ?>
                <?php if($this->user->checkPermission("quanlykho/nhanvien/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/nhanvien/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listnhanvien" class="sitemap treeindex">
                
            </div>
        	<?php echo $pager?>
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
function resetPass(id)
{
	showPopup("#popup", 500, 300, true )
	$("#popup-content").load("?route=quanlykho/nhanvien/resetPass&id="+id);
}

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/nhanvien/delete", 
				$("#listitem").serialize(), 
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

$('.text').keyup(function(e) {
    searchForm();
});
$('select').change(function(e) {
    searchForm();
});
function loadData(url)
{
	var page = control.getParam('page');
	if(page!="")
		url+="&page="+page;
	$('#listnhanvien').html(loading);
	$('#listnhanvien').load(url);
}
function viewAll()
{
	url = "?route=quanlykho/nhanvien/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_nhanvien #manhanvien").val() != "")
		url += "&manhanvien=" + $("#frm_nhanvien #manhanvien").val();
	
	if($("#frm_nhanvien #hoten").val() != "")
		url += "&hoten="+ encodeURI($("#frm_nhanvien #hoten").val());
	
	if($("#frm_nhanvien #maphongban").val() != "")
		url += "&maphongban="+ encodeURI($("#frm_nhanvien #maphongban").val());
	if($("#frm_nhanvien #machucvu").val() != "")
		url += "&machucvu=" + encodeURI($("#frm_nhanvien #machucvu").val());
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData("?route=quanlykho/nhanvien/getList"+url);
}

function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>