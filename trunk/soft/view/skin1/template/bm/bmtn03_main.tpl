<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">        	
        
        <div class="clearer">^&nbsp;</div>
        <h3>Các phiếu đề xuất mua vật tư, nguyên liệu(BM-VT-03) đã được phê duyệt</h3>
        <table>
            <thead>
                <tr>
                    <th>Số phiếu</th>
                    <th>Nhân viên lập</th>
                    <th>Ngày lập</th>
                    
                   
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <?php foreach($data_bmvt03 as $item){ ?>
                <tr>
                    <td><?php echo $item['sophieu']?></td>
                    <td><?php echo $this->document->getNhanVien($item['nhanvienlap'])?></td>
                    <td><?php echo $this->date->formatMySQLDate($item['ngaylapphieu'])?></td>
                </tr>
                <tr>
                	<td id="dotgiaohang-<?php echo $item['id']?>" bmvt03id="<?php echo $item['id']?>" class="dotgiaohang" colspan="3">
                    	
                    </td>
                </tr>
                <?php } ?>
            </tbody>
        </table>
            
        
        
        
    </div>
    
</div>
<script language="javascript">
function BMTN13()
{
	this.loadDotGiaoHang = function(bmvt03id)
	{
		$('#formshow').load("?route=bm/bmtn13/dotGiaoHang&bmvt03id="+bmvt03id);
	}
}
var bmtn13 = new BMTN13();
$(document).ready(function(e) {
    $('.dotgiaohang').each(function(index, element) {
        var bmvt03id = $(this).attr('bmvt03id');
		bmtn13.loadDotGiaoHang(bmvt03id);
    });
});
</script>