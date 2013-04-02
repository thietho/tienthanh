<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_nguyenlieu">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="manguyenlieu" name="manguyenlieu" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tennguyenlieu" name="tennguyenlieu" class="text" value="" />
                
                <label>Loại</label>
                <select id="loai" name="loai">
                    <option value=""></option>
                    <?php foreach($loainguyenlieu as $val){ ?>
                    <option value="<?php echo $val['manhom']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;",$val['level']-1)?><?php echo $val['tennhom']?></option>
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
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/vattu'"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	
                <?php }else{ ?>
                <?php if($this->user->checkPermission("quanlykho/vattu/viewTonKho")==true){ ?>
                <input class="button" value="Chi tiết tồn kho" type="button" onclick="viewTonKho('')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/vattu/xemgia")==true){ ?>
                <input class="button" value="Bảng báo giá" type="button" onclick="linkto('<?php echo $bangbaogia?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/vattu/insertlist")==true){ ?>
                <input class="button" value="Thêm nhiều vật tư" type="button" onclick="linkto('<?php echo $insertlist?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/vattu/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/vattu/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listnguyenlieu" class="sitemap treeindex">
                
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
		$.post("?route=quanlykho/vattu/deletedBangBaoGia", 
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
	url = "?route=quanlykho/vattu/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listnguyenlieu').html(loading);
	$('#listnguyenlieu').load(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_nguyenlieu #manguyenlieu").val() != "")
		url += "&manguyenlieu=" + encodeURI($("#frm_nguyenlieu #manguyenlieu").val());
	
	if($("#frm_nguyenlieu #tennguyenlieu").val() != "")
		url += "&tennguyenlieu="+ encodeURI($("#frm_nguyenlieu #tennguyenlieu").val());
	
	if($("#frm_nguyenlieu #loai").val() != "")
		url += "&loai="+ $("#frm_nguyenlieu #loai").val();
	if($("#frm_nguyenlieu #makho").val() != "")
		url += "&makho=" + $("#frm_nguyenlieu #makho").val();
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listnguyenlieu').html(loading);
	$('#listnguyenlieu').load("?route=quanlykho/vattu/getList"+url);
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectnguyenlieu").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectnguyenlieu").val($("#selectnguyenlieu").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>

function viewTonKho(id)
{
	$("#popup").attr('title','Tồn kho');
				$( "#popup" ).dialog({
					autoOpen: false,
					show: "blind",
					hide: "explode",
					width: 800,
					height: 500,
					modal: true,
					buttons: {
						
						
						'Đóng': function() {
							$( this ).dialog( "close" );
						},
						
						
					}
				});
			
				
	$("#popup-content").load("?route=quanlykho/vattu/viewTonKho&id="+id,function(){
		$("#popup").dialog("open");	
	});
	//openDialog("?route=quanlykho/vattu/viewTonKho&id="+id,1000,800);
}

function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
</script>