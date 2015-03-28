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
            	
                <?php }else{ ?>
                <?php if($this->user->checkPermission("quanlykho/sanpham/insertlist")==true){ ?>
                <input class="button" value="Thêm nhiều sản phẩm" type="button" onclick="linkto('<?php echo $insertlist?>#page='+control.getParam('page',strurl))">
                <?php } ?>
                
                
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/sanpham/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="showSanPhamForm('')">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/sanpham/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Delete" onclick="deleteitem()"/>
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
				$("#frm_sanpham").serialize(), 
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
	var page = control.getParam('page',control.getUrl());
	if(page!="")
		url+="&page="+page;
	$('#listsanpham').html(loading);
	$('#listsanpham').load(url);
}
function viewAll()
{
	url = "?route=quanlykho/sanpham/getList";
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
	loadData("?route=quanlykho/sanpham/getList"+url);
}
function viewSanPham(masanpham)
{
	openDialog("?route=quanlykho/sanpham/lichsu&masanpham="+masanpham,1000,800);
}

function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
function showSanPhamForm(id)
{
	var eid = "sanphamform";
	$('body').append('<div id="'+eid+'" style="display:none"></div>');
	
	$("#"+eid).attr('title','Sản phẩm');
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
	
					$.post("?route=quanlykho/sanpham/save", $("#frm_sanpham_form").serialize(),
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
	
		
		$("#"+eid).load("?route=quanlykho/sanpham/update&id="+id+"&dialog=true",function(){
			$("#"+eid).dialog("open");	
		})
}
</script>