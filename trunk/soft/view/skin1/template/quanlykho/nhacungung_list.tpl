<div class="section">

	<div class="section-title">Quản lý danh mục nhà cung ứng</div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_nhacungung">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="manhacungung" name="manhacungung" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tennhacungung" name="tennhacungung" class="text" value="" />
                <label>Nhóm</label>
					<select id="manhom" name="manhom">
                    	<option value=""></option>
                   		<?php foreach($nhomnhacungung as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
                <label>Địa chỉ</label>
                <input type="text" id="diachi" name="diachi" class="text" value="" /><br />
                <label>Khu vực</label>
                <select id="khuvuc" name="khuvuc">
                    <option value=""></option>
                    <?php foreach($khuvuc as $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                    <?php } ?>
                </select>
                <label>Điện thoại</label>
                <input type="text" id="dienthoai" name="dienthoai" class="text" value="" />
                <label>Fax</label>
                <input type="text" id="fax" name="fax" class="text" value="" />
                <label>Người đứng đầu</label>
                <input type="text" id="tennguoidungdau" name="tennguoidungdau" class="text" value="" />
               	
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	
                <?php } ?>
                <?php if($dialog!=true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>  
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listnhacungcap" class="sitemap treeindex">
                
        	</div>
        </form>
        
    </div>
    
</div>
<script language="javascript">
$(document).ready(function(e) {
    viewAll();
});
function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/nhacungung/delete", 
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
function viewAll()
{
	url = "?route=quanlykho/nhacungung/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listnhacungcap').load(url);
}
function searchForm()
{
	var url =  "";
	<?php if($dialog==true){ ?>
		url += "&opendialog=true";
	<?php } ?>
	if($("#frm_nhacungung #manhacungung").val() != "")
		url += "&manhacungung=" + $("#frm_nhacungung #manhacungung").val();
	
	if($("#frm_nhacungung #tennhacungung").val() != "")
		url += "&tennhacungung="+ encodeURI($("#frm_nhacungung #tennhacungung").val());
	if($("#frm_nhacungung #manhom").val() != "")
		url += "&manhom="+ $("#frm_nhacungung #manhom").val();
	if($("#frm_nhacungung #diachi").val() != "")
		url += "&diachi=" + encodeURI($("#frm_nhacungung #diachi").val());
	if($("#frm_nhacungung #khuvuc").val() != "")
		url += "&khuvuc=" + $("#frm_nhacungung #khuvuc").val();
	if($("#frm_nhacungung #dienthoai").val() != "")
		url += "&dienthoai="+ encodeURI($("#frm_nhacungung #dienthoai").val());
	if($("#fax").val() != "")
		url += "&fax=" + encodeURI($("#fax").val());
	if($("#frm_nhacungung #tennguoidungdau").val() != "")
		url += "&tennguoidungdau=" + encodeURI($("#frm_nhacungung #tennguoidungdau").val());
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	//window.location = url;
	$('#listnhacungcap').load("?route=quanlykho/nhacungung/getList"+url);
}



$("#manhacungung").val("<?php echo $_GET['manhacungung']?>");
$("#tennhacungung").val("<?php echo $_GET['tennhacungung']?>");
$("#manhom").val("<?php echo $_GET['manhom']?>");
$("#diachi").val("<?php echo $_GET['diachi']?>");
$("#khuvuc").val("<?php echo $_GET['khuvuc']?>");
$("#dienthoai").val("<?php echo $_GET['dienthoai']?>");
$("#fax").val("<?php echo $_GET['fax']?>");
$("#tennguoidungdau").val("<?php echo $_GET['tennguoidungdau']?>");

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectnhacungcung").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectnhacungcung").val($("#selectnhacungcung").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>
</script>