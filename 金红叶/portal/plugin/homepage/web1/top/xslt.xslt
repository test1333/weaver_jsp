<?xml version="1.0" encoding="GBK"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="GBK"/>
	<xsl:param name="currpath">/portal/plugin/homepage/web1/top</xsl:param>	
	
	<xsl:template match="/">	
		<div id="divMainMenu">			
			
			
     		        <xsl:call-template name="TreeNode">   
			     <xsl:with-param name="Nodes" select="tree/*" />   
	                </xsl:call-template> 
		</div>
	</xsl:template>
	<xsl:template name="TreeNode">   
	 <!--�������ϵĽڵ�ͨ��param������-->   
	 <xsl:param name="Nodes" />   
	 <!--ѭ�������ӽڵ㣬��Item-->   
	 <xsl:for-each select="$Nodes">   
	  <!--�����ӽڵ������-->   
	  	 
	  <xsl:variable name="Count" select="count(tree)" />   	  	
	  <xsl:variable name="linkAddress" select="@linkAddress" /> 
	  <xsl:variable name="icon" select="@icon" /> 
	  <xsl:variable name="openmode" select="@baseTarget" /> 
	  <xsl:variable name="id" select="@id" />  
	  <xsl:variable name="display" select="@display" /> 
	  

	  <!--������¼����㣬��ݹ��ȡ�ڵ�-->   
	  <xsl:if test="$Count>0">   
	  <xsl:choose>
		<xsl:when test="$display=1">
			  <ul id="ul_leftMenu_{$id}" style="display:block">
			   <xsl:call-template name="TreeNode">   
			     <xsl:with-param name="Nodes" select="*" />   
			    </xsl:call-template>
			   </ul>
		</xsl:when>
		  <xsl:otherwise>
			  <ul id="ul_leftMenu_{$id}" style="display:none">
			   <xsl:call-template name="TreeNode">   
			     <xsl:with-param name="Nodes" select="*" />   
			    </xsl:call-template>
			   </ul>
		</xsl:otherwise>
	 </xsl:choose>

	  
	   
	   

	  </xsl:if>   
	 </xsl:for-each>   
	</xsl:template>   
</xsl:stylesheet>
