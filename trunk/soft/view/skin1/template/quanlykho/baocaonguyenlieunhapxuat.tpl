<script src='<?php echo DIR_JS?>ui.datepicker.js' type='text/javascript' language='javascript'> </script>
<div class="section">

	<div class="section-title">Báo cáo nhập xuất nguyên liệu phát sinh theo kho</div>
    
    <div class="section-content">
    	<form id="frmbaocao" method="post">
            <div id="ben-search">
                <label>Chon kho</label>
                <select id="makho" name="makho">
                    <option value=""></option>
                    <?php foreach($kho as $val){ ?>
                    <option value="<?php echo $val['makho']?>"><?php echo $val['tenkho']?></option>
                    <?php } ?>
                </select>
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
                
               
                <input type="button" class="button" name="btnSearch" value="Lập báo cáo" onclick="lapBaoCao()"/>
                <input type="button" class="button" name="btnSearch" value="In báo cáo" onclick="inBaoCao()"/>
            </div>
        </form>
        <div class="clearer">^&nbsp;</div>
        
    	<div id="container" class="hidden padding1">
            
        </div>
    </div>
    
</div>
<script src="<?php echo DIR_JS?>jquery.tabs.pack.js" type="text/javascript"></script>
<script language="javascript">
$(document).ready(function() {
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
});

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