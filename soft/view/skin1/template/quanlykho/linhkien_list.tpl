<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <form action="" method="post" id="frm_linhkien">
        	<div id="ben-search">
            	<label>Mã số</label>
                <input type="text" id="malinhkien" name="malinhkien" class="text" value="" />
                <label>Tên</label>
                <input type="text" id="tenlinhkien" name="tenlinhkien" class="text" value="" />
                
                
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
                <?php if($this->user->checkPermission("quanlykho/linhkien/insertlist")==true){ ?>
                <input class="button" value="Thêm nhiều linh kiện" type="button" onclick="linkto('<?php echo $insertlist?>#page='+control.getParam('page',strurl))">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/linhkien/insert")==true){ ?>
                <input class="button" value="Thêm" type="button" onclick="linkto('<?php echo $insert?>#page='+control.getParam('page',strurl))">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/linhkien/delete")==true){ ?>
            	<input class="button" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
                <?php } ?>
            </div>
            <div class="clearer">^&nbsp;</div>
            
            <div id="listlinhkien" class="sitemap treeindex">
                
            </div>
        	
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
$(document).ready(function(e) {
    viewAll();
});
function loadData(url)
{
	var page = control.getParam('page',control.getUrl());
	if(page!="")
		url+="&page="+page;
	$('#listlinhkien').html(loading);
	$('#listlinhkien').load(url);
}
function viewAll()
{
	url = "?route=quanlykho/linhkien/getList";
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
	if($("#frm_linhkien #malinhkien").val() != "")
		url += "&malinhkien=" + encodeURI($("#frm_linhkien #malinhkien").val());
	
	if($("#frm_linhkien #tenlinhkien").val() != "")
		url += "&tenlinhkien="+ encodeURI($("#frm_linhkien #tenlinhkien").val());
	
	
	if($("#frm_linhkien #makho").val() != "")
		url += "&makho=" + encodeURI($("#frm_linhkien #makho").val());
	
	if("<?php echo $_GET['opendialog']?>" == "true")
	{
		url += "&opendialog=true";
	}
	loadData("?route=quanlykho/linhkien/getList"+url);
}

function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/linhkien/delete", 
				$("#frm_linhkien").serialize(), 
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

function selectLinhKien()
{
	window.opener.document.getElementById('selectmalinhkien').value = $("#selectlinhkien").val();
	window.close();
}

<?php if($dialog==true){ ?>
	$(".inputchk").click(function()
	{
		$("#selectlinhkien").val('');
		$(".inputchk").each(function(){
			if(this.checked == true)
			{
				$("#selectlinhkien").val($("#selectlinhkien").val()+","+$(this).val());
			}
		})
		
	});
<?php } ?>
function moveto(url,eid)
{
	$(eid).html(loading);
	$(eid).load(url);	
}
function showLinhKienForm(id)
{
	var eid = "linhkienform";
	$('body').append('<div id="'+eid+'" style="display:none"></div>');
	
	$("#"+eid).attr('title','Linh kiện');
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
	
					$.post("?route=quanlykho/linhkien/save", $("#frm_linhkien_form").serialize(),
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
	
		
		$("#"+eid).load("?route=quanlykho/linhkien/update&id="+id+"&dialog=true",function(){
			$("#"+eid).dialog("open");	
		})
}
</script>