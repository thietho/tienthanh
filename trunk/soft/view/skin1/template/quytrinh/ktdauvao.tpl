<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">        	
        <div class="button right">
            <input class="button" id="btnLapBMTN13" value="Lập phiếu yêu cầu kết quả nghiệm thu (BM-TN-13)" type="button">
            <input class="button" value="Lập phiếu kế quả thử nghiệm (BM-TN-14)" type="button">
        </div>
        <div class="clearer">^&nbsp;</div>
        <div id="formshow">
        </div>
            
        
        
        
    </div>
    
</div>
<script language="javascript">
function loadData(url)
{
	$('#formshow').html(loading);
	$('#formshow').load(url);
}
$('#btnLapBMTN13').click(function(e) {
    loadData('?route=bm/bmtn13/create');
});
</script>