<SCRIPT LANGUAGE="JavaScript">
function selectTableRow()
{
 var src="BODY")
 {
  if(table.tagName=="TABLE")
  {
   if(table.selectRow=="true")
   {
    tabFlag = true;
    break;
   }
  }
  else if(table.tagName=="TD")
  {
   cellObj = table;
  }
  else if(table.tagName=="TR")
  {
   srcObj = table;
  }
  table=table.parentElement;
 }
 if(tabFlag)
 {
  if(cellObj.tagName=="TD" && srcObj.tagName=="TR")
  {
   var nRowNum = srcObj.rowIndex;
   if(nRowNum==0)return false;
   selectRow(table,nRowNum);
   return true;
  }
 }
 return false;
 
}
function selectRow(tempTable,rowIndex)
{
   if(rowIndex==tempTable.selectedrow)
     return;
    srcObj=tempTable.rows[rowIndex];
 //注:如果预先没有定义样式则返回
    if(!srcObj.className)
  return;
   srcObj.oldClass=srcObj.className;
   if(srcObj.oldClass.indexOf("T_")==0)
    return;  
   if(tempTable.selectedrow>0)
   {
      tempTable.rows[tempTable.selectedrow].className=tempTable.rows[tempTable.selectedrow].oldClass;
   }
   srcObj.className="selectedRow";
   tempTable.selectedrow=rowIndex; 
}
</script>
