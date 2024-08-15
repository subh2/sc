#!/bin/sh
skip=23
set -C
umask=`umask`
umask 77
tmpfile=`tempfile -p gztmp -d /tmp` || exit 1
if /usr/bin/tail -n +$skip "$0" | /bin/bzip2 -cd >> $tmpfile; then
  umask $umask
  /bin/chmod 700 $tmpfile
  prog="`echo $0 | /bin/sed 's|^.*/||'`"
  if /bin/ln -T $tmpfile "/tmp/$prog" 2>/dev/null; then
    trap '/bin/rm -f $tmpfile "/tmp/$prog"; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile "/tmp/$prog") 2>/dev/null &
    /tmp/"$prog" ${1+"$@"}; res=$?
  else
    trap '/bin/rm -f $tmpfile; exit $res' 0
    (/bin/sleep 5; /bin/rm -f $tmpfile) 2>/dev/null &
    $tmpfile ${1+"$@"}; res=$?
  fi
else
  echo Cannot decompress $0; exit 1
fi; exit $res
BZh91AY&SY.��g  ���0 @}�����~����P�P�P�  @ i�    2h�4�dhbF���� 8ɓF�Ѧ##C��4�� a�L�4�1�Ѧ �h0��L&�0��4����Ѧ�=S'�S�7�@����l��?^�G���;i�3��\��z��
)(q�dX������@:Bp.�.�d�����	�@���+���Q0Md�^ =e��q��%�������q���ȄR{�/���D��`am8���f���=��D�@�5��D�1����	�W�d#ŗI��H��v�P�T���Y�2����w�#��xAǼ=�cn/jd�8.p�(�/��bo�_�3� h���r��<8د�7 �"�9᲻O�������úp�>��y=�7 �5�`�$�m?ri�D+r;O�*.�ގ��l��t�&p�@Mjp6:���x4EH��p����F���k���WI��0��p�$��.�P�y(Z�t�S� �D�:Y�
C�kXz,W�W9�g��k\\�w�g���N�6�b��s�Q������*�qX=p�f��a�^�e2�,�s�����-1��',��O)���u��bW���\���4�
-��V�$��K|*��8�pYh�0�����Q���l�T����}�P
��T���d�q���`q�*޺�h0f?�g�7��!I��͵d����&��406�;���HD�p�����pn, �m
݋��/���_�L�"ÐZ����/�a"�B�V����R�Q*�*/P�����1�e�4c#���c�������x�E@Bтe���U�p)6(���$�!����%י�(�,��H�
�L�