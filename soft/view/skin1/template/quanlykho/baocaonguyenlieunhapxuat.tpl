<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section">

	<div class="section-title">Báo cáo nhập xuất nguyên liệu phát sinh theo kho</div>
    
    <div class="section-content">
    	<form id="frmbaocao" method="post">
            <div id="ben-search">
            	<p>
                    <label>Chon kho</label>
                    <select id="makho" name="makho">
                        <option value=""></option>
                        <?php foreach($kho as $val){ ?>
                        <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                        <?php } ?>
                    </select>
                </p>
                <p>
                	<label>Tháng</label>
                    <select id="thang" name="thang">
                    	<?php for($i=1;$i<=12;$i++){ ?>
                    	<option value="<?php echo $i?>"><?php echo $i?></option>
                        <?php } ?>
                    </select>
                    <label>Năm</label>
                    <select id="nam" name="nam">
                    	<?php foreach($data_year as $year){ ?>
                        <option value="<?php echo $year['year']?>"><?php echo $year['year']?></option>
                        <?php } ?>
                    </select>
                </p>
                <p>
                    <label>Từ ngày</label>
                    <script language="javascript">
                        $(function() {
                            $("#tungay").datepicker({
                                    changeMonth: true,
                                    changeYear: true,
                                    dateFormat: 'dd-mm-yy'
                                    });
                            });
                     </script>
                     <input type="text" id="tungay" name="tungay" class="text" />
                     
                    <label>Đến ngày</label>
                    <script language="javascript">
                    $(function() {
                        $("#denngay").datepicker({
                                changeMonth: true,
                                changeYear: true,
                                dateFormat: 'dd-mm-yy'
                                });
                        });
                    </script>
                    <input type="text" id="denngay" name="denngay" class="text"/>
                </p>
               
                <input type="button" class="button" name="btnSearch" value="Xem báo cáo" onclick="lapBaoCao()"/>
                
            </div>
        </form>
        <div class="clearer">^&nbsp;</div>
        
    	<div id="container" class="hidden padding1">
            
        </div>
    </div>
    
</div>
<script src="<?php echo DIR_JS?>jquery.tabs.pack.js" type="text/javascript"></script>

<script language="javascript">
$('#thang').val("<?php echo $this->date->now['mon']?>");
$('#nam').val("<?php echo $this->date->now['year']?>");
$('#thang').change(function(e) {
    getMonthToDay();
});
$('#nam').change(function(e) {
    getMonthToDay();
});
$(document).ready(function() {
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	getMonthToDay();
});
function getMonthToDay()
{
	$.getJSON("?route=common/date/getMonthToDay",
		{
			month:$('#thang').val(),
			year:$('#nam').val()	
		},
		function(data){
			$('#tungay').val(data.startdate);
			$('#denngay').val(data.enddate);
		});
}
function lapBaoCao()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/baocaonguyenlieunhapxuat/showReport", $("#frmbaocao").serialize(),
		function(data){
			$('#container').html(data).show();
			$.unblockUI();				
		}
	);
	
}

</script>