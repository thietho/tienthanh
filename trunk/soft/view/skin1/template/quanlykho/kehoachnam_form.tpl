
<div class="section" id="sitemaplist">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content padding1">



<div class="button right">
	<input type="button" id="btnSave" value="Save" class="button" />
    <input type="button" value="Cancel" class="button" onclick="linkto('?route=quanlykho/kehoachnam')" />
   
</div>
<div class="clearer">^&nbsp;</div>
<div id="error" class="error" style="display: none"></div>
<div id="container">
    <ul class="tabs-nav">
        <li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin kế hoạch</span></a></li>
        <li class="tabs"><a href="#fragment-chitiet"><span>Chi tiết</span></a></li>
    </ul>
    <div id="fragment-thongtin">
    <form id="frm">
        <p>
            <label>Năm</label><br />
            <?php if(!$isUpdate){?>
            <select id="nam" name="nam">
                <?php for($i=$this->date->now['year']-5;$i <= $this->date->now['year']+5;$i++){ ?>
                <option value="<?php echo $i?>"><?php echo $i?></option>
                <?php } ?>
            </select>
            <?php }else{ ?>
            <?php echo $item['nam']?>
            <input type="hidden" id="nam" name="nam" value="<?php echo $item['nam']?>" />
            <input type="hidden" id="id" name="id" value="<?php echo $item['nam']?>" />
            <?php }?>
        </p>
        <p><label>Ghi chú</label><br />
        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
        </p>
    </form>
    </div>
    <div id="fragment-chitiet">
    </div>
</div>


</div>

</div>
<script language="javascript">
$(document).ready(function(e) {
    $('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	$.blockUI({ message: "<h1 id=warningstatus>Please wait...</h1>"}); 
	$('#fragment-chitiet').load("?route=quanlykho/kehoachnam/loadKehoachSanPham&nam=<?php echo $item['nam']?>",function(){
		
		$.unblockUI();
		numberReady();
	});
});
$('#nam').val("<?php echo $item['nam']?>");
$('#btnSave').click(function(e) {
    $.blockUI({ message: "<h1 id=warningstatus>Please wait...</h1>"}); 
	
	$.post("?route=quanlykho/kehoachnam/save", $("#frm").serialize(),
		function(data){
			var arr = data.split('-');
			if(arr[0] == "true")
			{
				//Luu chi tiet ke hoach
				window.location = "?route=quanlykho/kehoachnam";
				//saveitem(0)
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
});

function saveitem(pos)
{
	//$('#warningstatus').html( Math.round(pos/count*100)+"%");
	var sanphamid = $('#row_khoachnam_sanpham'+pos+' #sanphamid').val();
	var masanpham = $('#row_khoachnam_sanpham'+pos+' #masanpham').val();
	var tensanpham = $('#row_khoachnam_sanpham'+pos+' #tensanpham').val();
	var manhom = $('#row_khoachnam_sanpham'+pos+' #manhom').val();
	var giacodinh = $('#row_khoachnam_sanpham'+pos+' #giacodinh').val();
	var sosanphamtrenlot = $('#row_khoachnam_sanpham'+pos+' #sosanphamtrenlot').val();
	var qui1 = $('#row_khoachnam_sanpham'+pos+' #qui1').val();
	var qui2 = $('#row_khoachnam_sanpham'+pos+' #qui2').val();
	var qui3 = $('#row_khoachnam_sanpham'+pos+' #qui3').val();
	var qui4 = $('#row_khoachnam_sanpham'+pos+' #qui4').val();
	
	
	
	$.post("?route=quanlykho/kehoachnam/savechitietkehoach",
		{
			
			nam:$('#nam').val(),
			sanphamid:sanphamid,
			masanpham:masanpham,
			tensanpham:tensanpham,
			manhom:manhom,
			giacodinh:giacodinh,
			sosanphamtrenlot:sosanphamtrenlot,
			qui1:qui1,
			qui2:qui2,
			qui3:qui3,
			qui4:qui4
		}
		,
		function(data){
			var arr = data.split('-');
			if(arr[0] == "true")
			{
				//window.location = "?route=quanlykho/kehoachnam";
				//saveitem(pos+1);
			}
			else
			{
				//$('#warningstatus').html("Completed...");
				//setTimeout("$.unblockUI();window.location = '?route=quanlykho/kehoachnam'",2000);
				
				
				
				
			}
			$.unblockUI();
			
		}
	);
}
</script>
