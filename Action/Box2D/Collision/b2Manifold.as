package Box2D.Collision
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;

    public class b2Manifold extends Object
    {
        public var points:Array;
        public var pointCount:int = 0;
        public var normal:b2Vec2;

        public function b2Manifold()
        {
            var _loc_1:* = 0;
            pointCount = 0;
            points = new Array(b2Settings.b2_maxManifoldPoints);
            _loc_1 = 0;
            while (_loc_1 < b2Settings.b2_maxManifoldPoints)
            {
                
                points[_loc_1] = new b2ManifoldPoint();
                _loc_1++;
            }
            normal = new b2Vec2();
            return;
        }// end function

        public function Set(param1:b2Manifold) : void
        {
            var _loc_2:* = 0;
            pointCount = param1.pointCount;
            _loc_2 = 0;
            while (_loc_2 < b2Settings.b2_maxManifoldPoints)
            {
                
                (points[_loc_2] as b2ManifoldPoint).Set(param1.points[_loc_2]);
                _loc_2++;
            }
            normal.SetV(param1.normal);
            return;
        }// end function

        public function Reset() : void
        {
            var _loc_1:* = 0;
            _loc_1 = 0;
            while (_loc_1 < b2Settings.b2_maxManifoldPoints)
            {
                
                (points[_loc_1] as b2ManifoldPoint).Reset();
                _loc_1++;
            }
            normal.SetZero();
            pointCount = 0;
            return;
        }// end function

    }
}
