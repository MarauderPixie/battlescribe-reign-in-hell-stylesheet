<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:bs="http://www.battlescribe.net/schema/rosterSchema" 
                xmlns:exslt="http://exslt.org/common" 
                extension-element-prefixes="exslt">
    <xsl:output method="html" indent="yes"/>

	<xsl:template match="bs:roster/bs:forces">
    <html>
		<head>
			<style>
            @import url("https://fonts.googleapis.com/css2?family=Cambo&amp;display=swap");
            body {
                font-family: 'Cambo', sans-serif;
                font-size: 0.8em; }
            .card {
                width: 12cm;
                min-height: 4.0cm;
                background-color: #ffffff;
                border: 2px solid #555555;
                border-radius: 0.4em;
                margin-bottom: 0.5cm;
                font-size: 0.9em; }
            .card .card-header {
                color: #000000;
                font-size: 1em;
                font-variant-caps: small-caps;
                background-color: #f4f4f4;
                border-top-left-radius: 0.4em;
                border-top-right-radius: 0.4em;
                text-align: left;
                /* text-transform: uppercase; */
                padding: 0.2cm; }
            .card .wound-track {
                height: 2.5cm;
                width: 5cm;
                float: right;
                z-index: 1;
                position: absolute;
                margin-left: 10.2cm;
                background-color: white;
                border: 2px solid #555555;
                border-bottom-left-radius: 0.4em;
                border-bottom-right-radius: 0.4em; }
            .card .wound-track span {
                color: #FF0000;
                font-weight: bold; }
            .card .wound-track .wound-track-header {
                padding: 2px 4px;
                font-size: 0.6em; }
            .card .wound-track table {
                width: 100%;
                font-size: 0.7em;
                border-collapse: collapse;
                text-align: center; }
            /* .card .wound-track tr {
                background-color: #FFFFFF; }
            .card .wound-track tr:nth-child(odd) {
                background-color: #AFB7A4; }
            .card .wound-track tr::nth-child(even) {
                background-color: #FFFFFF; }
            .card .wound-track th {
                background-color: #748A4E; } */
            table {
                border-collapse: collapse;
                margin: 5px;
                float: left;
            }

            /* table .abilities {
                float: left;
            } */
            tr {
                font-size: 0.5em;
                background-color: #fff; 
            }
            tr:nth-child(odd) {
                font-size: 2em;
                text-align: center;
                border-bottom: 2px solid #aaa;   
                /* border-image: url(https://www.worldanvil.com/uploads/images/570410efbb0c11476af474932082da6c.png) 100 round; */
            }

            .hitbox {
                height: 14px;
                width: 14px;
                background-color: #fff;
                border: 1px solid #555555;
                display: inline-block;
                margin-right: 5px;
            }
            .hitbox:first-of-type {
                margin-top: 12px;
                margin-left: 24px;
            }

            .abilities {
                color: red;
            }
            .essences {
                color: green;
            }
            .relics {
                color: blue;
            }
            </style>
		</head>
	
        <body>
			<xsl:call-template name="roster"/>
			<xsl:apply-templates select="bs:force" mode="cards"/>
	    </body>
	</html>
	</xsl:template>


<!-- GENERAL CABAL STUFF !-->
<xsl:template name="roster">
    <section class="roster-header">
        <h1><xsl:value-of select="../@name"/></h1>
        <h2><xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/@name"/></h2>
    </section>

    <section class="roster-body">
        <p><b> <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/bs:profiles/bs:profile[3]/@name"/>: </b> <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/bs:profiles/bs:profile[3]/bs:characteristics/bs:characteristic"/> </p>
        <p><b> <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/bs:profiles/bs:profile[2]/@name"/>: </b> <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/bs:profiles/bs:profile[2]/bs:characteristics/bs:characteristic"/> </p>
    </section>
    
    <section id="roster-footer" class="roster-footer">    
    </section>
</xsl:template>

<!-- CARD STUFF? !-->
<xsl:template match="bs:force" mode="cards">
	<!-- Render cards template -->
	<xsl:apply-templates select="bs:selections/bs:selection[@type='upgrade' or @type='unit']"/>
</xsl:template>

<xsl:template match="bs:selections/bs:selection[@type='upgrade' or @type='unit']">
		<div class="card">
			<!-- <xsl:if test="bs:profiles/bs:profile[@typeName='Wound Track (M/BS/A)']">
				<div class="wound-track">
					<div class="wound-track-header">
						<span>DAMAGE</span><br/>
						Some of this models characteristics change as it suffers damage, as shown below:
					</div>
					<table>
						<tr>
								<xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Wound Track (M/BS/A)'][1]" mode="header"/>																
						</tr>
						<xsl:for-each select="bs:profiles/bs:profile[@typeName='Wound Track (M/BS/A)']">
							<tr>
								<xsl:apply-templates select="." mode="body"/>											
							</tr>
						</xsl:for-each>
					</table>
				</div>
			</xsl:if> !-->
			<div class="card-header">
				<b><xsl:value-of select="./@name"/></b> - <xsl:value-of select="bs:categories/bs:category/@name"/>
			</div>
			<div class="card-body">
				<table class="unit" cellspacing="0">
					<!-- <tr>
							<th>
									Name
							</th>
							<xsl:apply-templates select="bs:profiles/bs:profile[@typeName='unit']" mode="header"/>
							<xsl:apply-templates select="bs:selections/bs:selection[@type='model']/bs:profiles/bs:profile[@typeName='unit']" mode="header"/>
							<th></th>
					</tr> !-->
					<tr>
                        <td>
                            <!-- <xsl:choose>
                                <xsl:when test="bs:selections/bs:selection[@type='model']">
                                    <xsl:value-of select="bs:selections/bs:selection[@type='model']/@name"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="@name"/>
                                </xsl:otherwise>
                            </xsl:choose> !-->
                            <xsl:value-of select="bs:profiles/bs:profile[@typeId='b8bf-34dc-6f26-5b03']/bs:characteristics/bs:characteristic[@name='Move']"/>
                        </td>
                            <!-- <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='unit']" mode="body"/>
                            <xsl:apply-templates select="bs:selections/bs:selection[@type='model']/bs:profiles/bs:profile[@typeName='unit']" mode="body"/>
						<td></td> !-->
					</tr>
                    <tr><td>Move</td></tr>
                    <tr><td>
                        <xsl:value-of select="bs:profiles/bs:profile[@typeId='b8bf-34dc-6f26-5b03']/bs:characteristics/bs:characteristic[@name='Combat']"/>
                    </td></tr>
                    <tr><td>Combat</td></tr>
				</table>

                <p class="abilities"> <!-- DECLARE ABILITIES !-->
                    <xsl:variable name="ability-name" select="bs:profiles/bs:profile[@typeId='8366-9fc7-d1ad-f62b']"/>
                    <!-- <b><i><xsl:value-of select="bs:profiles/bs:profile[@typeId='8366-9fc7-d1ad-f62b']/@name"/></i></b> - <xsl:value-of select="bs:profiles/bs:profile[@typeId='8366-9fc7-d1ad-f62b']/bs:characteristics/bs:characteristic"/> !-->
                    <xsl:for-each select="$ability-name">
                        <b><i><xsl:value-of select="@name"/></i></b> - <xsl:value-of select="bs:characteristics/bs:characteristic"/> <br />
                    </xsl:for-each>
                </p>


                <xsl:variable name="leader-gear" select="bs:selections/bs:selection/bs:profiles/bs:profile"/>
                <p class="essences"> <!-- DECLARE ESSENCES !-->
                    <xsl:if test="$leader-gear/@typeName='Leader Essence'">
                        <b><i><xsl:value-of select="$leader-gear/@name"/></i></b> - <xsl:value-of select="$leader-gear/bs:characteristics/bs:characteristic"/><br />
                    </xsl:if>

                    <xsl:variable name="essences" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Essence']"/>
                    <xsl:for-each select="$essences">
                        <b><i><xsl:value-of select="@name"/>: </i></b> <xsl:value-of select="bs:characteristics/bs:characteristic"/><br />
                    </xsl:for-each>
                </p>

                <p class="relics"> <!-- DECLARE RELICS
                         -> since every demon can only ever have one, the for-each might as well just go away 
                         -> maybe create CSS classes (for abilities, essences and relics)? !-->
                    <xsl:if test="$leader-gear/@typeName='Leader Relic'">
                        <b><i><xsl:value-of select="$leader-gear[@typeName='Leader Relic']/@name"/></i></b> - <xsl:value-of select="$leader-gear[@typeName='Leader Relic']/bs:characteristics/bs:characteristic"/><br />
                    </xsl:if>
                    
                    <xsl:variable name="relics" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Relic']"/>
                    <xsl:for-each select="$relics">
                        <b><i><xsl:value-of select="@name"/>: </i></b> <xsl:value-of select="bs:characteristics/bs:characteristic"/>
                    </xsl:for-each>
                </p>
            </div>
		</div>
</xsl:template>

</xsl:stylesheet>