<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">        	
        <div class="button right">
        	<input class="button" id="btnListBMTN13" value="Phiếu đề xuất mua vật tư, nguyên liệu (BM-VT-03)" type="button">
        	<input class="button" id="btnLapBMVT03" value="Lập phiếu đề xuất mua vật tư, nguyên liệu (BM-VT-03)" type="button">
            <!--<input class="button" id="btnListBMTN13" value="Phiếu yêu cầu kết quả nghiệm thu (BM-TN-13)" type="button">
            <input class="button" id="btnLapBMTN13" value="Lập phiếu yêu cầu kết quả nghiệm thu (BM-TN-13)" type="button">
            <input class="button" id="btnListBMTN14" value="Phiếu kết quả thử nghiệm (BM-TN-14)" type="button">
            <input class="button" id="btnLapBMTN14" value="Lập phiếu kết quả thử nghiệm (BM-TN-14)" type="button">-->
        </div>
        <div class="clearer">^&nbsp;</div>
        <div id="formshow">
        </div>
            
        
        
        
    </div>
    
</div>
<script language="javascript">
function KTDauVao()
{
	this.loadData = function(url)
	{
		$('#formshow').html(loading);
		$('#formshow').load(url);
	}
}
var ktdv = new KTDauVao();
$('#btnLapBMVT03').click(function(e) {
    ktdv.loadData('?route=bm/bmvt03/create');
});
/*$('#btnListBMTN13').click(function(e) {
    ktdv.loadData('?route=bm/bmtn13/getList');
});
$('#btnLapBMTN13').click(function(e) {
    ktdv.loadData('?route=bm/bmtn13/create');
});
$('#btnListBMTN14').click(function(e) {
    ktdv.loadData('?route=bm/bmtn14/getList');
});
$('#btnLapBMTN14').click(function(e) {
    ktdv.loadData('?route=bm/bmtn14/create');
});*/
</script>