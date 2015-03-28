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
                <input type="button" class="button" name="btnSearch" value="Xem tất cả" onclick="viewAll()"/>
            </div>
        	<div class="button right">
            	<?php if($dialog==true){ ?>
            	
                <?php }else{ ?>
                <?php if($this->user->checkPermission("quanlykho/nguyenlieu/viewTonKho")==true){ ?>
                <input class="button" value="Chi tiết tồn kho" type="button" onclick="viewTonKho('')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/nguyenlieu/xemgia")==true){ ?>
                <input class="button" value="Bảng báo giá" type="button" onclick="linkto('<?php echo $bangbaogia?>')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/nguyenlieu/insertlist")==true){ ?>
                <input class="button" value="Thêm nhiều nguyên liệu" type="button" onclick="linkto('<?php echo $insertlist?>#page='+control.getParam('page',strurl))">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/nguyenlieu/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="showNguyenLieuForm('')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/nguyenlieu/delete")==true){ ?>
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
		$.post("?route=quanlykho/nguyenlieu/delete", 
				$("#frm_nguyenlieu").serialize(), 
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
	var page = control.getParam('page',control.getUrl());
	if(page!="")
		url+="&page="+page;
	$('#listnguyenlieu').html(loading);
	$('#listnguyenlieu').load(url);
}
function viewAll()
{
	url = "?route=quanlykho/nguyenlieu/getList";
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData(url);
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
	loadData("?route=quanlykho/nguyenlieu/getList"+url);
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
					width: $(document).width()-100,
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
	$(eid).html(loading);
	$(eid).load(url);	
}
function showNguyenLieuForm(id)
{
	var eid = "nguyenlieuform";
	$('body').append('<div id="'+eid+'" style="display:none"></div>');
	
	$("#"+eid).attr('title','Nguyên liệu');
		$("#"+eid).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: $(document).width()-100,
			height: window.innerHeight,
			modal: true,
			close:function()
				{
					$("#"+eid).remove();
				},
			buttons: {
				
				'Lưu':function()
				{
					$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
					$.post("?route=quanlykho/nguyenlieu/save", $("#frm_nguyenlieu_form").serialize(),
						function(data){
							if(data == "true")
							{
								
								$("#"+eid).dialog( "close" );
								searchForm();
							}
							else
							{
							
								$('#error').html(data).show('slow');
								
								
							}
							$.unblockUI();
							
						}
					);
				},
				'Đóng': function() 
				{
					
					$("#"+eid).dialog( "close" );
					
				},
			}
		});
	
		
		$("#"+eid).load("?route=quanlykho/nguyenlieu/update&id="+id+"&dialog=true",function(){
			$("#"+eid).dialog("open");	
		})
}
</script>