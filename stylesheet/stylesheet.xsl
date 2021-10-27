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
            @import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@500&amp;display=swap');
            @import url('https://fonts.googleapis.com/css2?family=Lusitana&amp;display=swap');

            @font-face {
                font-family: "Democratika";
                src: url("/home/tobi/.fonts/democratika.ttf");
            }

            /* @media print{@page {size: landscape}} */

            @media (orientation: landscape) {
            body {
                font-family: 'Lusitana', serif;
                font-size: 0.8em; 
                flex-direction: column;
            }

            h1 {
                font-family: Cinzel, Democratika, serif;
                /* font-size: 54pt; */
                font-weight: bold;
                margin-bottom: 0;
                display: inline-block;
            }
            h2 {
                font-family: Cinzel, Democratika, serif;
                /* font-size: 54pt; */
                margin-top: 0;
                font-weight: normal;
                display: inline-block;
            }

            p {
                padding: 5px 10px;
                margin-block-start: 0em;
                margin-block-end: 0em;
            }

            .card {
                float: left;
                margin: 12px;
                width: 12cm;
                min-height: 4.5cm;
                background-color: #ffffff;
                /* border: 2px solid #555555;
                border-radius: 0.4em; */
                border: 10px solid transparent;
                padding: 5px;
                border-image: url(https://www.worldanvil.com/uploads/images/570410efbb0c11476af474932082da6c.png) 10 stretch;
                margin-bottom: 0;
                font-size: 0.8em; 
                page-break-inside: avoid;
            }
            .card .card-header {
                color: #000000;
                font-size: 1.1em;
                font-variant-caps: small-caps;
                /* background-color: #f4f4f4; */
                border-top-left-radius: 0.4em;
                border-top-right-radius: 0.4em;
                text-align: left;
                /* text-transform: uppercase; */
                padding: 0.2cm; 
            }


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
                margin: 1px 8px 8px 5px;
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
                font-size: 1.3em;
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
                margin-left: 8px;
            }
            .hitbox:nth-child(3n+2) {
                background-color: #E3E2E2;
            }

            .abilities {
                color: black;
            }
            .essences {
                color: black;
            }
            .relics {
                color: black;
            }
            }
            </style>
		</head>
	
        <body>
			<xsl:call-template name="roster"/>
            <!-- evtl. lässt sich hier einiges abkürzen, wenn ich hinter bs:force noch
                 /bs:selections/bs:selection packe? !-->
			<xsl:apply-templates select="bs:force" mode="cards"/>
	    </body>
	</html>
	</xsl:template>


<!-- GENERAL CABAL STUFF !-->
<xsl:template name="roster">
    <section class="roster-header">
        <h1><xsl:value-of select="../@name"/> - </h1>
        <h2>A Cabal of <xsl:value-of select="bs:force/bs:selections/bs:selection/bs:selections/bs:selection/@name"/> Demons</h2>
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
    <!-- <xsl:variable name="sortOrder" select="'|Leader|Devout|Minion|'" /> -->
    
	<xsl:apply-templates select="bs:selections/bs:selection[@type='unit' or @type='upgrade' and @name!='Game Options']">
        <!-- <xsl:sort data-type="number" select="string-length(substring-before($sortOrder, @result))" /> -->
        <xsl:sort select="bs:categories/bs:category[@entryId='0894-68fa-8134-6e32' or @entryId='3436-8e6e-a8f6-716e' or @entryId='e534-8b74-6056-9e87']/@name" />
    </xsl:apply-templates>
</xsl:template>

<xsl:template match="bs:selections/bs:selection[@type='unit' or @type='upgrade' and @name!='Game Options']">
		<div class="card">
			<div class="card-header" style="align: left">
                    <b><xsl:value-of select="./@name"/></b> - <xsl:value-of select="bs:categories/bs:category/@name"/>
                    <span style="float: right">
                    <xsl:choose>
                        <xsl:when test="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Title']">
                            <b><xsl:value-of select="@customName"/> the <xsl:value-of select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Title']/@name"/> </b>
                        </xsl:when>
                        <xsl:otherwise>
                            <b><xsl:value-of select="@customName"/></b>
                        </xsl:otherwise>
                    </xsl:choose>
                    </span>
			</div>
			<div class="card-body">
				<table class="unit" cellspacing="0">
                    <tr>
                        <td>
                            <xsl:value-of select="bs:profiles/bs:profile[@typeId='b8bf-34dc-6f26-5b03']/bs:characteristics/bs:characteristic[@name='Life']"/>
                        </td>
					</tr>
                    <tr><td>Life</td></tr>
					<tr>
                        <td>
                            <xsl:value-of select="bs:profiles/bs:profile[@typeId='b8bf-34dc-6f26-5b03']/bs:characteristics/bs:characteristic[@name='Move']"/>
                        </td>
					</tr>
                    <tr><td>Move</td></tr>
                    <tr><td>
                        <xsl:value-of select="bs:profiles/bs:profile[@typeId='b8bf-34dc-6f26-5b03']/bs:characteristics/bs:characteristic[@name='Combat']"/>
                    </td></tr>
                    <tr><td>Combat</td></tr>
				</table>

                
                <!-- LIFE TRACKER !-->
                <b>Wounds:</b><xsl:call-template name="life-tracker" />
                
                
                <!-- DECLARE TITLE !-->
                <xsl:if test="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Title']">
                    <p class="title">
                        <b><i><xsl:value-of select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Title']/@name"/>: </i></b>
                        <xsl:value-of select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Title']/bs:characteristics/bs:characteristic"/>
                    </p>
                </xsl:if>

                
                <p class="abilities"> <!-- DECLARE ABILITIES !-->
                    <xsl:variable name="ability-name" select="bs:profiles/bs:profile[@typeId='8366-9fc7-d1ad-f62b']"/>
                    <!-- <b><i><xsl:value-of select="bs:profiles/bs:profile[@typeId='8366-9fc7-d1ad-f62b']/@name"/></i></b> - <xsl:value-of select="bs:profiles/bs:profile[@typeId='8366-9fc7-d1ad-f62b']/bs:characteristics/bs:characteristic"/> !-->
                    <xsl:for-each select="$ability-name">
                        <b><i><xsl:value-of select="@name"/> - </i></b><xsl:value-of select="bs:characteristics/bs:characteristic"/> <br />
                    </xsl:for-each>
                </p>


                <xsl:variable name="leader-gear" select="bs:selections/bs:selection/bs:profiles/bs:profile"/>
                <xsl:if test="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Essence' or @typeName='Leader Essence']">
                    <p class="essences"> <!-- DECLARE ESSENCES !-->
                        <xsl:if test="$leader-gear/@typeName='Leader Essence'">
                            <b><i><xsl:value-of select="$leader-gear/@name"/> - </i></b><xsl:value-of select="$leader-gear/bs:characteristics/bs:characteristic"/><br />
                        </xsl:if>

                        <xsl:variable name="essences" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Essence']"/>
                        <xsl:for-each select="$essences">
                            <b><i><xsl:value-of select="@name"/> - </i></b><xsl:value-of select="bs:characteristics/bs:characteristic"/><br />
                        </xsl:for-each>
                    </p>
                </xsl:if>

                
                <xsl:if test="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Relic' or @typeName='Leader Relic']">
                    <p class="relics"> <!-- DECLARE RELICS
                            -> since every demon can only ever have one, the for-each might as well just go away 
                                -> then again, there's a title that allows for more
                            -> maybe create CSS classes (for abilities, essences and relics)? !-->
                        <xsl:if test="$leader-gear/@typeName='Leader Relic'">
                            <b><i><xsl:value-of select="$leader-gear[@typeName='Leader Relic']/@name"/> - </i></b><xsl:value-of select="$leader-gear[@typeName='Leader Relic']/bs:characteristics/bs:characteristic"/><br />
                        </xsl:if>
                        
                        <xsl:variable name="relics" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Relic']"/>
                        <xsl:for-each select="$relics">
                            <b><i><xsl:value-of select="@name"/> - </i></b> <xsl:value-of select="bs:characteristics/bs:characteristic"/>
                        </xsl:for-each>
                    </p>
                </xsl:if>
            </div>
		</div>
</xsl:template>

<xsl:template name="life-tracker">
    <xsl:param name="index" select="1" />
    <xsl:param name="maxValue" select="bs:profiles/bs:profile[@typeId='b8bf-34dc-6f26-5b03']/bs:characteristics/bs:characteristic[@name='Life']" />

    <div class="hitbox"></div>
    
    <!-- &lt; represents "<" for html entities -->
    <xsl:if test="$index &lt; $maxValue">
        <xsl:call-template name="life-tracker">
            <xsl:with-param name="index" select="$index + 1" />
            <xsl:with-param name="maxValue" select="$maxValue" />
        </xsl:call-template>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>