select *
from post
where ( doro || ' ' || building1 ) = '����5�� 19';

select zipcode || CHR(10)
|| sido || ' ' || doro || ' ' || building1 || ' ' || decode(dong, NULL, '', '(' || dong || decode(building, NULL, '', ', ' || building) || ')') || CHR(10) 
|| sido || ' ' || dong || ' ' || decode(building, NULL, '', '(' || building || ') ') || decode(zibun2, 0, '', zibun2)
from post
where ( doro || ' ' || building1 ) = '����5�� 19';

select zipcode || CHR(10)
|| sido || ' ' 
|| decode(eupmyun, NULL, '', eupmyun || ' ') 
|| doro || ' ' 
|| building1 
|| decode(building2, 0, '', '-' || building2) || ' '
|| decode(dong, NULL, '', '(' || dong 
|| decode(building, NULL, '', ', ' || building) || ')') 
|| decode(ri, NULL, '', '(' || ri || ')') || CHR(10) 
|| sido || ' ' 
|| decode(eupmyun, NULL, '', eupmyun) 
|| decode(dong, NULL, '', dong) || ' ' 
|| decode(ri, NULL, '', ri || ' ')
|| decode(building, NULL, '', '(' || building || ') ') 
|| decode(eupmyun, NULL, '', zibun1 
|| decode(zibun2, 0, '', '-' || zibun2) )
from post
where ( doro || ' ' || building1 || '-' || building2 ) = '��õ2�� 27-17'
or ( doro || ' ' || building1 ) = '����5�� 19';

--�÷� �м�
--�����ȣ: NOT NULL
--�õ�: NOT NULL
--���θ�: NOT NULL
--�ñ���: NULLABLE
--����: NULLABLE
--��: NULLABLE
--��: NULLABLE
--����1, ����2: NULLABLE
--�ǹ���: NULLABLE

select * 
from post 
where building1 = '0' or building1 is null; --building1�� NOT NULL

select *
from post
where dong is null and ri is null; --��, �� �Ѵ� null�� ���� ����

--�̷������� Į���� ���� �˻��� �м��� �� �ִ�

--�ּ� ���� �м�
--���θ� �ּ�: �õ�, �ñ���, ����, ���θ�, �ǹ���, �ǹ���ȣ1-�ǹ���ȣ2, (�� �Ǵ� ��, �ǹ���)
--���� �ּ�: �õ�, �ñ���, ����, �� �Ǵ� ��, ����1-����2, (�ǹ���)

SELECT zipcode,
sido || ' '
|| sigungu || NVL2(sigungu, ' ', '') --�ñ���: NULL�̸� ���� + �÷��� NULL�� ��� �� ���ڿ� ��� / NULL�� �ƴϸ� ���� ��ĭ ���
|| eupmyun || NVL2(eupmyun, ' ', '')
|| doro || ' '
|| building1
|| DECODE(building2, '0', '', '-'||building2) || ' '
|| '(' || dong || ri || DECODE(building, '', '', ', ' || building) || ')'
|| chr(13) || chr(10) --�ٹٲ�
|| sido ||' ' 
|| sigungu ||NVL2(sigungu,' ', '')
|| eupmyun ||NVL2(eupmyun,' ', '')
|| dong || ri ||' ' ||  zibun1 || DECODE(zibun2, '0', '',  '-'|| zibun2)    || DECODE(building, '', '', ' (' ||building ||')')
FROM post
WHERE ( doro || ' ' || building1 || DECODE(building2, '0', '', '-'||building2)) = '������ 2511';
