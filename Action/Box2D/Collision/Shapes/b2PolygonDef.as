package Box2D.Collision.Shapes
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;

    public class b2PolygonDef extends b2ShapeDef
    {
        public var vertexCount:int;
        public var vertices:Array;
        private static var s_mat:b2Mat22 = new b2Mat22();

        public function b2PolygonDef()
        {
            var _loc_1:* = 0;
            vertices = new Array(b2Settings.b2_maxPolygonVertices);
            type = b2Shape.e_polygonShape;
            vertexCount = 0;
            _loc_1 = 0;
            while (_loc_1 < b2Settings.b2_maxPolygonVertices)
            {
                
                vertices[_loc_1] = new b2Vec2();
                _loc_1++;
            }
            return;
        }// end function

        public function SetAsOrientedBox(param1:Number, param2:Number, param3:b2Vec2 = null, param4:Number = 0) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            vertexCount = 4;
            vertices[0].Set(-param1, -param2);
            vertices[1].Set(param1, -param2);
            vertices[2].Set(param1, param2);
            vertices[3].Set(-param1, param2);
            if (param3)
            {
                _loc_5 = param3;
                _loc_6 = s_mat;
                _loc_6.Set(param4);
                _loc_7 = 0;
                while (_loc_7 < vertexCount)
                {
                    
                    param3 = vertices[_loc_7];
                    param1 = _loc_5.x + (_loc_6.col1.x * _loc_5.x + _loc_6.col2.x * _loc_5.y);
                    _loc_5.y = _loc_5.y + (_loc_6.col1.y * _loc_5.x + _loc_6.col2.y * _loc_5.y);
                    _loc_5.x = param1;
                    _loc_7++;
                }
            }
            return;
        }// end function

        public function SetAsBox(param1:Number, param2:Number) : void
        {
            vertexCount = 4;
            vertices[0].Set(-param1, -param2);
            vertices[1].Set(param1, -param2);
            vertices[2].Set(param1, param2);
            vertices[3].Set(-param1, param2);
            return;
        }// end function

    }
}
