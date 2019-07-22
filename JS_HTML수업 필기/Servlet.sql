SELECT zipcode, 
					 sido|| ' ' 
					 || sigungu || NVL2(sigungu,' ', '')
					 || eupmyun || NVL2(eupmyun,' ', '')
					 || doro ||' ' 
					 || building1
					 || DECODE(building2,'0', '', '-'||building2) ||' '
					 || '('|| dong || ri || DECODE(building, '', '', ',' ||building) ||')'
					 AS addr1, 
					 sido ||' ' 
					 || sigungu ||NVL2(sigungu,' ', '')
					 || eupmyun ||NVL2(eupmyun,' ', '')
					 || dong || ri ||' ' 
					 || zibun1 || DECODE(zibun2, '0', '',  '-'|| zibun2)
					 || DECODE(building, '', '', ' (' ||building ||')') 
					 AS addr2 
					 FROM post 
					 WHERE (doro || ' ' || building1 || DECODE(building2,'0', '', '-'||building2)) LIKE '%µµ¿ò5·Î%';