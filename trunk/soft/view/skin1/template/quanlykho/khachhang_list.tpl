<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_khachhang">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="makhachhang" name="makhachhang" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="hoten" name="hoten" class="text" value="" />
                <label>Khu vực</label>
                <select id="khuvuc" name="khuvuc">
                    <option value=""></option>
                    <?php foreach($khuvuc as $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                    <?php } ?>
                </select>
                <label>Loại khách hàng</label>
                <select id="loaikhachhang" name="loaikhachhang">
                    <option value=""></option>
                    <?php foreach($loaikhachhang as $key => $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
                    <?php } ?>
                </select>
                <br />
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
            <!-- end search -->
            
        	<div class="button right">
                <?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectKhachHang()">
                <input type="hidden" id="selectkhachhang" name="selectkhachhang" />
                <?php } ?>
                <?php if($dialog!=true){ ?>
                <?php if($this->user->checkPermission("quanlykho/khachhang/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/khachhang/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>  
            </div>
            
            <div class="clearer">^&nbsp;</div>
            
            <div id="listkhachhang" class="sitemap treeindex">
                
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
		$.post("?route=quanlykho/khachhang/delete", 
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
function viewAll()
{
	url = "?route=quanlykho/khachhang/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listkhachhang').load(url);
}

function searchForm()
{
	var url =  "";
	
	if($("#frm_khachhang #makhachhang").val() != "")
		url += "&makhachhang=" + $("#frm_khachhang #makhachhang").val();
	
	if($("#frm_khachhang #hoten").val() != "")
		url += "&hoten="+ encodeURI($("#frm_khachhang #hoten").val());
	if($("#frm_khachhang #khuvuc").val() != "")
		url += "&khuvuc="+ encodeURI($("#frm_khachhang #khuvuc").val());
	if($("#frm_khachhang #loaikhachhang").val() != "")
		url += "&loaikhachhang="+ encodeURI($("#frm_khachhang #loaikhachhang").val());
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	$('#listkhachhang').load("?route=quanlykho/khachhang/getList"+url);
}


</script>