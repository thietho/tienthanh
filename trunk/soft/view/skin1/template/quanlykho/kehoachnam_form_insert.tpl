
<div class="section" id="sitemaplist">

<div class="section-title"><?php echo $this->document->title?></div>

<div class="section-content padding1">

<div class="clearer">^&nbsp;</div>
<div id="error" class="error" style="display: none"></div>
<div id="container">
    
    <div id="fragment-thongtin">
    <form id="frm">
        <p>
            <label>Năm</label><br />
            
            <select id="nam" name="nam">
                <?php for($i=$this->date->now['year']-5;$i <= $this->date->now['year']+5;$i++){ ?>
                <option value="<?php echo $i?>"><?php echo $i?></option>
                <?php } ?>
            </select>
            
        </p>
        <p><label>Ghi chú</label><br />
        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
        </p>
    </form>
    </div>
    
</div>


</div>

</div>
<script language="javascript">
$('#nam').val("<?php echo $item['nam']?>");

</script>
