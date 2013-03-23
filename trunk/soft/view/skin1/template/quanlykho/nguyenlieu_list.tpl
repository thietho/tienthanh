<div class="section">

	<div class="section-title">Quản lý danh mục nguyên vật liệu</div>
    
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
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="window.location = '?route=quanlykho/nguyenlieu'"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	
                <?php }else{ ?>
                <input class="button" value="Chi tiết tồn kho" type="button" onclick="viewTonKho('')">
                <?php if($this->user->getUserTypeId() == "admin"){ ?>
                <input class="button" value="Bảng báo giá" type="button" onclick="linkto('<?php echo $bangbaogia?>')">
                <?php } ?>
                <input class="button" value="Thêm nhiều nguyên liệu" type="button" onclick="linkto('<?php echo $insertlist?>')">
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>')">
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
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
		$.post("?route=quanlykho/nguyenlieu/delete", 
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
	url = "?route=quanlykho/nguyenlieu/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	$('#listnguyenlieu').load(url);
}

function searchForm()
{
	var url =  "";
	if($("#frm_nguyenlieu #manguyenlieu").val() != "")
		url += "&manguyenlieu=" + $("#frm_nguyenlieu #manguyenlieu").val();
	
	if($("#frm_nguyenlieu #tennguyenlieu").val() != "")
		url += "&tennguyenlieu="+ encodeURI($("#frm_nguyenlieu #tennguyenlieu").val());
	
	if($("#frm_nguyenlieu #loai").val() != "")
		url += "&loai="+ encodeURI($("#frm_nguyenlieu #loai").val());
	if($("#frm_nguyenlieu #makho").val() != "")
		url += "&makho=" + encodeURI($("#frm_nguyenlieu #makho").val());
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	
	$('#listnguyenlieu').load("?route=quanlykho/nguyenlieu/getList"+url);
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
			
				
	$("#popup-content").load("?route=quanlykho/nguyenlieu/viewTonKho&id="+id,function(){
		$("#popup").dialog("open");	
	});
	//openDialog("?route=quanlykho/nguyenlieu/viewTonKho&id="+id,1000,800);
}

function moveto(url,eid)
{
	$(eid).load(url);	
}
</script>