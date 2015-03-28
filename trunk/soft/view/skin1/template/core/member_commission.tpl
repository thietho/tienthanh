<script src="<?php echo DIR_JS?>tabletoexcel.js" type="text/javascript"></script>
<div class="section">

	<div class="section-title"><?php echo $member['fullname']?></div>
    
    <div class="section-content">
    	
        <form id="frm_thongke">
        	<div id="ben-search">
            	<input type="hidden" id="memberid" name="memberid" value="<?php echo $member['id']?>"/>
                <label>Từ ngày</label>
                <input type="text" class="text date" id="tungay" name="tungay" />
                <script language="javascript">
                $(function() {
                    $("#tungay").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            dateFormat: 'dd-mm-yy'
                            });
                    });
                </script>
                <label>Đến ngày</label>
                <input type="text" class="text date" id="denngay" name="denngay" />
                <script language="javascript">
                $(function() {
                    $("#denngay").datepicker({
                            changeMonth: true,
                            changeYear: true,
                            dateFormat: 'dd-mm-yy'
                            });
                    });
                </script>
                
                <br />
                <input type="button" class="button" id="btnThongKe" name="btnThongKe" value="Xem"/>
                
            </div>
        	
            <div class="clearer">^&nbsp;</div>
            
            <div id="showresult">
                
            </div>
        	<input type="button" class="button" id="btnSaveToExcel" name="btnSaveToExcel" value="Lưu thành excel"/>
        
        </form>
        
    </div>
    
</div>
<script language="javascript">
$('#btnThongKe').click(function(e) {
	$('#showresult').html(loading);
    $.post("?route=core/member/thongke", 
		$("#frm_thongke").serialize(), 
		function(html)
		{
			$('#showresult').html(html);
		}
	);
});
$('#btnSaveToExcel').click(function(e) {
	tableToExcel('reportbanhang', 'Ho Lan Solutions');
});
</script>