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
        <div id="error" class="error" style="display:none"></div>
    	<div id="container" class="hidden">
            <ul class="tabs-nav">
                <li class="tabs-selected"><a href="#fragment-phatsinhnhap"><span>Phát sinh nhập</span></a></li>
                <li class="tabs"><a href="#fragment-phatsinhxuat"><span>Phát sinh xuất</span></a></li>
            </ul>

            <div id="fragment-phatsinhnhap" class="tabs-container">   
                <p>
                	<label>Phát sinh nhập kho nguyên liệu</label>
                    <table>
                    	<thead>
                        	<th>Ngày</th>
                            <th>Mã phiếu</th>
                            <th>Mã nguyên liệu</th>
                            <th>Tên nguyên liệu</th>
                            <th>Thực nhập</th>
                            <th>ĐVT</th>
                            <th>Đơn giá</th>
                            <th>Thành tiền</th>
                        </thead>
                        <tbody id="showphatsinhnhap">
                        </tbody>
                    </table>
                </p>
            </div>
            
            <!-- chi tiet phieu nhap nguyen lieu -->
            <div id="fragment-phatsinhxuat" class="tabs-container">
               	<p>
                	<label>Phát sinh xuất kho nguyên liệu</label>
                    <table>
                    	<thead>
                        	<th>Ngày</th>
                            <th>Mã phiếu</th>
                            <th>Mã nguyên liệu</th>
                            <th>Tên nguyên liệu</th>
                            <th>Thực xuất</th>
                            <th>ĐVT</th>
                            <th>Đơn giá</th>
                            <th>Thành tiền</th>
                        </thead>
                        <tbody id="showphatsinhxuat">
                        </tbody>
                    </table>
                </p>
            </div>
            <!-- end chi tiet phieu nhan hang -->
            
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
	
	$.post("?route=quanlykho/baocaonguyenlieunhapxuat/getPhieuNhapXuatNguyenLieu&loainhapxuat=phieunhapnguyenlieu", $("#frmbaocao").serialize(),
		function(data){
				$("#showphatsinhnhap").html(data);
				
				$.post("?route=quanlykho/baocaonguyenlieunhapxuat/getPhieuNhapXuatNguyenLieu&loainhapxuat=phieuxuatnguyenlieu", $("#frmbaocao").serialize(),
				function(data){
						$("#showphatsinhxuat").html(data);
						
						$("#container").show();
						$.unblockUI();
				}
			);
		}
	);
	
}

</script>