package wck
{
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import flash.geom.*;

    public class Shape extends Body
    {
        public var shapeDensity:Number = 1;
        public var shapeRestitution:Number = 0;
        public var b2shapes:Array;
        public var shapeGroupIndex:int = 0;
        public var selfBody:Boolean;
        public var shapeIsSensor:Boolean = false;
        public var shapeCategoryBits:String = "0x0001";
        public var body:Body;
        public var shapeFriction:Number = 0.2;
        public var shapeMaskBits:String = "0xFFFF";

        public function Shape()
        {
            shapeFriction = 0.2;
            shapeRestitution = 0;
            shapeDensity = 1;
            shapeIsSensor = false;
            shapeCategoryBits = "0x0001";
            shapeMaskBits = "0xFFFF";
            shapeGroupIndex = 0;
            b2shapes = [];
            return;
        }// end function

        public function createShape() : void
        {
            body = parent as Body;
            if (!body)
            {
                body = this;
                selfBody = true;
            }
            else
            {
                world = body.world;
            }
            addShapes([]);
            return;
        }// end function

        public function addShapes(param1:Array) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                b2shapes.push(body.b2body.CreateShape(_loc_2));
            }
            return;
        }// end function

        public function circleDef(param1:Number = -1, param2:Number = 0, param3:Number = 0) : b2CircleDef
        {
            var _loc_4:* = null;
            _loc_4 = new b2CircleDef();
            initializeDef(_loc_4);
            _loc_4.localPosition = b2Position(param2, param3);
            _loc_4.radius = (param1 == -1 ? (width / 2) : (param1 * scaleX)) * (selfBody ? (1) : (body.scaleX)) / world.scale;
            return _loc_4;
        }// end function

        public function initializeDef(param1:b2ShapeDef) : void
        {
            param1.userData = this;
            param1.friction = shapeFriction;
            param1.restitution = shapeRestitution;
            param1.density = shapeDensity;
            param1.filter.categoryBits = parseInt(shapeCategoryBits);
            param1.filter.maskBits = parseInt(shapeMaskBits);
            param1.filter.groupIndex = shapeGroupIndex;
            param1.isSensor = shapeIsSensor;
            return;
        }// end function

        public function b2Position(param1 = 0, param2 = 0) : b2Vec2
        {
            var _loc_3:* = null;
            if (selfBody)
            {
                return new b2Vec2(param1 * scaleX / world.scale, param2 * scaleY / world.scale);
            }
            _loc_3 = body.globalToLocal(localToGlobal(new Point(param1, param2)));
            return new b2Vec2(_loc_3.x * body.scaleX / world.scale, _loc_3.y * body.scaleY / world.scale);
        }// end function

        public function polygonDef(param1:Array) : b2PolygonDef
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_2 = new b2PolygonDef();
            initializeDef(_loc_2);
            _loc_2.vertices = [];
            for each (_loc_3 in param1)
            {
                
                _loc_2.vertices.push(b2Position(_loc_3[0], _loc_3[1]));
            }
            _loc_2.vertexCount = _loc_2.vertices.length;
            return _loc_2;
        }// end function

        public function boxDef(param1:Number = -1, param2:Number = -1, param3:Number = 0, param4:Number = 0, param5:Number = 0) : b2PolygonDef
        {
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            _loc_6 = new b2PolygonDef();
            initializeDef(_loc_6);
            _loc_7 = rotation;
            rotation = 0;
            _loc_6.SetAsOrientedBox((param1 == -1 ? (width / 2) : (param1 * scaleX)) * (selfBody ? (1) : (body.scaleX)) / world.scale, (param2 == -1 ? (height / 2) : (param2 * scaleY)) * (selfBody ? (1) : (body.scaleY)) / world.scale, b2Position(param3, param4), ((selfBody ? (0) : (_loc_7)) + param5) * Math.PI / 180);
            rotation = _loc_7;
            return _loc_6;
        }// end function

        public function polygonListDef(param1:Array) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_2 = [];
            for each (_loc_3 in param1)
            {
                
                _loc_2.push(polygonDef(_loc_3));
            }
            return _loc_2;
        }// end function

    }
}
