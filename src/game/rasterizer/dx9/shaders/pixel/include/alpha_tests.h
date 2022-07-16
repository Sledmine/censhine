half4 TestAlphaGreaterRef(half4 col, float ref)
{
   clip(col.a - ref);
   return col;
}

half4 TestAlphaGreater00(half4 col)
{
   clip(col.a - 0.001); // 0x00 < 0.001 < 0x01 = 0.00392156862745098039
   return col;
}

half4 TestAlphaGreater7F(half4 col)
{
   clip(col.a - 0.5); // 0x7F < 0.5 < 0x80 = 0.5019607843137254902
   return col;
}
