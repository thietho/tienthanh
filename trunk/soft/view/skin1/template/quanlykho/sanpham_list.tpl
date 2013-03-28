<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_sanpham">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="masanpham" name="masanpham" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tensanpham" name="tensanpham" class="text" value="" />
                <label>Nhóm</label>
					<select id="manhom" name="manhom">
                    	<option value=""></option>
                    	<?php foreach($nhomsanpham as $val){ ?>
                        <option value="<?php echo $val['manhom']?>"><?php echo $val['tennhom']?></option>
                        <?php } ?>
                    </select>
                <label>Loại</label>
                <select id="loai" name="loai">
                    <option value=""></option>
                    <?php foreach($loaisanpham as $val){ ?>
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
                <input type="button" class="button" name="btnSearch" value="Tìm" onclick="searchForm()"/>
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	<input class="button" value="Select" type="button" onclick="selectSanPham()">
                <input type="hidden" id="selectsanpham" name="selectsanpham" />
                <?php }else{ ?>
                <?php if($this->user->checkPermission("quanlykho/sanpham/insertlist")==true){ ?>
                <input class="button" value="Thêm nhiều sản phẩm" type="button" onclick="linkto('<?php echo $insertlist?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/sanpham/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/sanpham/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Delete" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listsanpham" class="sitemap treeindex">
                
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
		$.post("?route=quanlykho/sanpham/delete", 
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
	url = "?route=quanlykho/sanpham/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listsanpham').load(url);
}

function searchForm()
{
	var url =  "";
	
	if($("#frm_sanpham #masanpham").val() != "")
		url += "&masanpham=" + $("#frm_sanpham #masanpham").val();
	
	if($("#frm_sanpham #tensanpham").val() != "")
		url += "&tensanpham="+ encodeURI($("#frm_sanpham #tensanpham").val());
	if($("#frm_sanpham #manhom").val() != "")
		url += "&manhom="+ encodeURI($("#frm_sanpham #manhom").val());
	if($("#frm_sanpham #loai").val() != "")
		url += "&loai="+ encodeURI($("#frm_sanpham #loai").val());
	if($("#frm_sanpham #makho").val() != "")
		url += "&makho=" + encodeURI($("#frm_sanpham #makho").val());
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	$('#listsanpham').load("?route=quanlykho/sanpham/getList"+url);
}

function selectSanPham()
{
	window.opener.document.getElementById('selectsanpham').value = $("#selectsanpham").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectsanpham").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectsanpham").val($("#selectsanpham").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>

function viewSanPham(masanpham)
{
	
	openDialog("?route=quanlykho/sanpham/lichsu&masanpham="+masanpham,1000,800);
}
</script>