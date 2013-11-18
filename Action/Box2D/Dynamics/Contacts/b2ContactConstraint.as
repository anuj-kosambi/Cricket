package Box2D.Dynamics.Contacts
{
    import Box2D.Collision.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2ContactConstraint extends Object
    {
        public var points:Array;
        public var restitution:Number;
        public var body1:b2Body;
        public var manifold:b2Manifold;
        public var normal:b2Vec2;
        public var body2:b2Body;
        public var friction:Number;
        public var pointCount:int;

        public function b2ContactConstraint()
        {
            var _loc_1:* = 0;
            normal = new b2Vec2();
            points = new Array(b2Settings.b2_maxManifoldPoints);
            _loc_1 = 0;
            while (_loc_1 < b2Settings.b2_maxManifoldPoints)
            {
                
                points[_loc_1] = new b2ContactConstraintPoint();
                _loc_1++;
            }
            return;
        }// end function

    }
}
