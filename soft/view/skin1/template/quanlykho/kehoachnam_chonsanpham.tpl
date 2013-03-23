

<div class="section" id="sitemaplist">

<div class="section-title">Kê hoạch năm</div>

<div class="section-content padding1">

<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">

<div class="button right"><input type="button" value="Save"
	class="button" onClick="save()" /> <input type="button" value="Cancel"
	class="button" onclick="linkto('?route=quanlykho/kehoachnam')" /> <input
	type="hidden" name="makehoach" value="<?php echo $item['id']?>"></div>
<div class="clearer">^&nbsp;</div>
<div id="error" class="error" style="display: none"></div>
<div>
    <p><label>Năm:</label><?php echo $item['nam']?></p>
    <?php if($item['quy']>0){ ?>
    <p><label>Quý:</label><?php echo $item['quy']?></p>
    <?php } ?>
    <?php if($item['thang']>0){ ?>
    <p><label>Tháng:</label><?php echo $item['thang']?></p>
    <?php } ?>
    <p><label>Ghi chú</label><br />
    <?php echo $item['ghichu']?></p>
    <p>
    	<label>Sản phẩm:</label>
        <input type="text" class="text" id="txt_sanpham" name="txt_sanpham">
        <input type="text" class="text" id="txt_sanpham1" name="txt_sanpham1" style="display:none">
    </p>
    <div id="listkehoachsanpham">
    
    </div>



</div>

</form>

</div>

</div>

<script language="javascript">

    $(function() {
        
 
        $( "#txt_sanpham" ).autocomplete({
            source: function( request, response ) {
                $.ajax({
                    url: "?route=quanlykho/sanpham/getSanPham1",
                    dataType: "json",
                    data: {
                        col: "masanpham",
                        operator: "like",
                        maxrows: 12,
                        val: request.term
                    },
                    success: function( data ) {
                        response( $.map( data.sanphams, function( item ) {
                            return {
                                label: item.masanpham + (item.masanpham ? ", " + item.tensanpham : ""),
                                value: item.masanpham
                            }
                        }));
                    }
                });
            },
            minLength: 1,
            select: function( event, ui ) {
				
				var str = "<div><input type='hidden' name='masanpham[]' value='"+ui.item.value+"'>"+ui.item.label+" <input type='button' class='button delitem' value='Xóa'></div>";
				$("#listkehoachsanpham").append(str);
				$('.delitem').click(function(e) {
					$(this).parent().remove();
				});
                
            },
            open: function() {
                $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
            },
            close: function() {
                $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
				$(this).val('');
            }
        });
    });

</script>