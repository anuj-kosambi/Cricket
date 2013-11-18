package 
{
    import wck.*;

    dynamic public class DemoWorld1 extends World
    {
        public var __id0_:BatsmanJoint;
        public var __id1_:BatsmanJoint;
        public var __id2_:BatsmanJoint;
        public var __id3_:BatsmanJoint;
        public var __id4_:BatsmanJoint;
        public var __id5_:BatsmanJoint;
        public var __id6_:BatsmanJoint;
        public var __id7_:BatsmanJoint;
        public var __id10_:BatsmanJoint;
        public var __id11_:BatsmanJoint;
        public var __id8_:BatsmanJoint;
        public var __id9_:BatsmanJoint;
        public var __id12_:BatsmanJoint;
        public var __id13_:BatsmanJoint;

        public function DemoWorld1()
        {
            __setProp___id1__DemoWorld1_Joints_1();
            __setProp___id0__DemoWorld1_Joints_1();
            __setProp_head_DemoWorld1_Layer1_1();
            __setProp_zo_b_DemoWorld1_Scorezones_1();
            __setProp_z1_a_DemoWorld1_Scorezones_1();
            __setProp___id7__DemoWorld1_Joints_1();
            __setProp___id6__DemoWorld1_Joints_1();
            __setProp_rarm_DemoWorld1_Layer1_1();
            __setProp_chest_DemoWorld1_Layer1_1();
            __setProp_z2_a_DemoWorld1_Scorezones_1();
            __setProp___id3__DemoWorld1_Joints_1();
            __setProp___id2__DemoWorld1_Joints_1();
            __setProp_fthigh_DemoWorld1_Layer1_1();
            __setProp_z4_b_DemoWorld1_Scorezones_1();
            __setProp___id5__DemoWorld1_Joints_1();
            __setProp_bleg_DemoWorld1_Layer1_1();
            __setProp_z6_c_DemoWorld1_Scorezones_1();
            __setProp_z4_a_DemoWorld1_Scorezones_1();
            __setProp_z6_b_DemoWorld1_Scorezones_1();
            __setProp___id13__DemoWorld1_Joints_1();
            __setProp___id12__DemoWorld1_Joints_1();
            __setProp_larm_DemoWorld1_Layer1_1();
            __setProp_z6_a_DemoWorld1_Scorezones_1();
            __setProp_bthigh_DemoWorld1_Layer1_1();
            __setProp_rshoulder_DemoWorld1_Layer1_1();
            __setProp_wicket_DemoWorld1_Layer1_1();
            __setProp___id4__DemoWorld1_Joints_1();
            __setProp_bail_DemoWorld1_Layer1_1();
            __setProp___id10__DemoWorld1_Joints_1();
            __setProp___id8__DemoWorld1_Joints_1();
            __setProp_lshoulder_DemoWorld1_Layer1_1();
            __setProp_groundart_DemoWorld1_Layer1_1();
            __setProp___id11__DemoWorld1_Joints_1();
            __setProp___id9__DemoWorld1_Joints_1();
            __setProp_bat_DemoWorld1_Layer1_1();
            __setProp_fleg_DemoWorld1_Layer1_1();
            __setProp_ground_DemoWorld1_Layer1_1();
            __setProp_zo_a_DemoWorld1_Scorezones_1();
            return;
        }// end function

        function __setProp___id11__DemoWorld1_Joints_1()
        {
            try
            {
                __id11_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id11_.body2Name = "head";
            __id11_.bodyName = "chest";
            __id11_.collideConnected = false;
            __id11_.enableLimit = true;
            __id11_.enableMotor = false;
            __id11_.lineParameter = "0x888888";
            __id11_.lineStyle = "Line";
            __id11_.lowerLimit = 0;
            __id11_.pathReturns = false;
            __id11_.speed1 = 0;
            __id11_.speed2 = 0;
            __id11_.speedFlag = "";
            __id11_.spring = false;
            __id11_.springConstant = 0;
            __id11_.springDamping = 0;
            __id11_.strength = 0;
            __id11_.targetName = "";
            __id11_.type = "RevolutePin";
            __id11_.upperLimit = 0;
            try
            {
                __id11_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_z4_a_DemoWorld1_Scorezones_1()
        {
            try
            {
                z4_a["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            z4_a.bodyAllowSleep = true;
            z4_a.bodyAngularDamping = 0;
            z4_a.bodyApplyGravity = true;
            z4_a.bodyFixedRotation = false;
            z4_a.bodyIsBullet = false;
            z4_a.bodyIsSleeping = false;
            z4_a.bodyIsStatic = true;
            z4_a.bodyLinearDamping = 0;
            z4_a.shapeCategoryBits = "0x0001";
            z4_a.shapeDensity = 1;
            z4_a.shapeFriction = 0.2;
            z4_a.shapeGroupIndex = 0;
            z4_a.shapeIsSensor = true;
            z4_a.shapeMaskBits = "0xFFFF";
            z4_a.shapeRestitution = 0;
            try
            {
                z4_a["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id7__DemoWorld1_Joints_1()
        {
            try
            {
                __id7_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id7_.body2Name = "larm";
            __id7_.bodyName = "lshoulder";
            __id7_.collideConnected = false;
            __id7_.enableLimit = true;
            __id7_.enableMotor = false;
            __id7_.lineParameter = "0x888888";
            __id7_.lineStyle = "Line";
            __id7_.lowerLimit = -0.1;
            __id7_.pathReturns = false;
            __id7_.speed1 = 0;
            __id7_.speed2 = 0;
            __id7_.speedFlag = "";
            __id7_.spring = true;
            __id7_.springConstant = 15;
            __id7_.springDamping = 0.5;
            __id7_.strength = 0;
            __id7_.targetName = "";
            __id7_.type = "RevolutePin";
            __id7_.upperLimit = 2;
            try
            {
                __id7_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_rshoulder_DemoWorld1_Layer1_1()
        {
            try
            {
                rshoulder["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            rshoulder.bodyAllowSleep = true;
            rshoulder.bodyAngularDamping = 0;
            rshoulder.bodyApplyGravity = false;
            rshoulder.bodyFixedRotation = false;
            rshoulder.bodyIsBullet = false;
            rshoulder.bodyIsSleeping = false;
            rshoulder.bodyIsStatic = false;
            rshoulder.bodyLinearDamping = 0;
            rshoulder.shapeCategoryBits = "0x0004";
            rshoulder.shapeDensity = 1.4;
            rshoulder.shapeFriction = 0.2;
            rshoulder.shapeGroupIndex = -10;
            rshoulder.shapeIsSensor = false;
            rshoulder.shapeMaskBits = "0xFFE9";
            rshoulder.shapeRestitution = 0;
            try
            {
                rshoulder["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id4__DemoWorld1_Joints_1()
        {
            try
            {
                __id4_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id4_.body2Name = "bthigh";
            __id4_.bodyName = "bleg";
            __id4_.collideConnected = false;
            __id4_.enableLimit = true;
            __id4_.enableMotor = false;
            __id4_.lineParameter = "0x888888";
            __id4_.lineStyle = "Line";
            __id4_.lowerLimit = -1.2;
            __id4_.pathReturns = false;
            __id4_.speed1 = 0;
            __id4_.speed2 = 0;
            __id4_.speedFlag = "";
            __id4_.spring = true;
            __id4_.springConstant = 80;
            __id4_.springDamping = 0.8;
            __id4_.strength = 1;
            __id4_.targetName = "";
            __id4_.type = "RevolutePin";
            __id4_.upperLimit = 0.1;
            try
            {
                __id4_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_ground_DemoWorld1_Layer1_1()
        {
            try
            {
                ground["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            ground.bodyAllowSleep = true;
            ground.bodyAngularDamping = 0;
            ground.bodyApplyGravity = true;
            ground.bodyFixedRotation = false;
            ground.bodyIsBullet = false;
            ground.bodyIsSleeping = false;
            ground.bodyIsStatic = true;
            ground.bodyLinearDamping = 0;
            ground.shapeCategoryBits = "0x0001";
            ground.shapeDensity = 1;
            ground.shapeFriction = 0.7;
            ground.shapeGroupIndex = -5;
            ground.shapeIsSensor = false;
            ground.shapeMaskBits = "0xFFFB";
            ground.shapeRestitution = 0.2;
            try
            {
                ground["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id1__DemoWorld1_Joints_1()
        {
            try
            {
                __id1_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id1_.body2Name = "fleg";
            __id1_.bodyName = "ground";
            __id1_.collideConnected = false;
            __id1_.enableLimit = true;
            __id1_.enableMotor = false;
            __id1_.lineParameter = "0x888888";
            __id1_.lineStyle = "Line";
            __id1_.lowerLimit = -0.5;
            __id1_.pathReturns = false;
            __id1_.speed1 = 0;
            __id1_.speed2 = 0;
            __id1_.speedFlag = "";
            __id1_.spring = true;
            __id1_.springConstant = 150;
            __id1_.springDamping = 0.8;
            __id1_.strength = 0;
            __id1_.targetName = "";
            __id1_.type = "RevolutePin";
            __id1_.upperLimit = 0.5;
            try
            {
                __id1_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_z6_b_DemoWorld1_Scorezones_1()
        {
            try
            {
                z6_b["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            z6_b.bodyAllowSleep = true;
            z6_b.bodyAngularDamping = 0;
            z6_b.bodyApplyGravity = true;
            z6_b.bodyFixedRotation = false;
            z6_b.bodyIsBullet = false;
            z6_b.bodyIsSleeping = false;
            z6_b.bodyIsStatic = true;
            z6_b.bodyLinearDamping = 0;
            z6_b.shapeCategoryBits = "0x0001";
            z6_b.shapeDensity = 1;
            z6_b.shapeFriction = 0.2;
            z6_b.shapeGroupIndex = 0;
            z6_b.shapeIsSensor = true;
            z6_b.shapeMaskBits = "0xFFFF";
            z6_b.shapeRestitution = 0;
            try
            {
                z6_b["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_zo_a_DemoWorld1_Scorezones_1()
        {
            try
            {
                zo_a["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            zo_a.bodyAllowSleep = true;
            zo_a.bodyAngularDamping = 0;
            zo_a.bodyApplyGravity = true;
            zo_a.bodyFixedRotation = false;
            zo_a.bodyIsBullet = false;
            zo_a.bodyIsSleeping = false;
            zo_a.bodyIsStatic = true;
            zo_a.bodyLinearDamping = 0;
            zo_a.shapeCategoryBits = "0x0001";
            zo_a.shapeDensity = 1;
            zo_a.shapeFriction = 0.2;
            zo_a.shapeGroupIndex = 0;
            zo_a.shapeIsSensor = true;
            zo_a.shapeMaskBits = "0xFFFF";
            zo_a.shapeRestitution = 0;
            try
            {
                zo_a["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_rarm_DemoWorld1_Layer1_1()
        {
            try
            {
                rarm["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            rarm.bodyAllowSleep = true;
            rarm.bodyAngularDamping = 0;
            rarm.bodyApplyGravity = false;
            rarm.bodyFixedRotation = false;
            rarm.bodyIsBullet = false;
            rarm.bodyIsSleeping = false;
            rarm.bodyIsStatic = false;
            rarm.bodyLinearDamping = 0;
            rarm.shapeCategoryBits = "0x0004";
            rarm.shapeDensity = 1;
            rarm.shapeFriction = 0.2;
            rarm.shapeGroupIndex = -10;
            rarm.shapeIsSensor = false;
            rarm.shapeMaskBits = "0xFFE9";
            rarm.shapeRestitution = 0;
            try
            {
                rarm["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_z2_a_DemoWorld1_Scorezones_1()
        {
            try
            {
                z2_a["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            z2_a.bodyAllowSleep = true;
            z2_a.bodyAngularDamping = 0;
            z2_a.bodyApplyGravity = true;
            z2_a.bodyFixedRotation = false;
            z2_a.bodyIsBullet = false;
            z2_a.bodyIsSleeping = false;
            z2_a.bodyIsStatic = true;
            z2_a.bodyLinearDamping = 0;
            z2_a.shapeCategoryBits = "0x0001";
            z2_a.shapeDensity = 1;
            z2_a.shapeFriction = 0.2;
            z2_a.shapeGroupIndex = 0;
            z2_a.shapeIsSensor = true;
            z2_a.shapeMaskBits = "0xFFFF";
            z2_a.shapeRestitution = 0;
            try
            {
                z2_a["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id12__DemoWorld1_Joints_1()
        {
            try
            {
                __id12_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id12_.body2Name = "lshoulder";
            __id12_.bodyName = "chest";
            __id12_.collideConnected = false;
            __id12_.enableLimit = true;
            __id12_.enableMotor = false;
            __id12_.lineParameter = "0x888888";
            __id12_.lineStyle = "Line";
            __id12_.lowerLimit = -0.5;
            __id12_.pathReturns = false;
            __id12_.speed1 = 0;
            __id12_.speed2 = 0;
            __id12_.speedFlag = "";
            __id12_.spring = true;
            __id12_.springConstant = 50;
            __id12_.springDamping = 0.5;
            __id12_.strength = 1;
            __id12_.targetName = "";
            __id12_.type = "RevolutePin";
            __id12_.upperLimit = 1.1;
            try
            {
                __id12_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id8__DemoWorld1_Joints_1()
        {
            try
            {
                __id8_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id8_.body2Name = "rarm";
            __id8_.bodyName = "rshoulder";
            __id8_.collideConnected = false;
            __id8_.enableLimit = true;
            __id8_.enableMotor = false;
            __id8_.lineParameter = "0x888888";
            __id8_.lineStyle = "Line";
            __id8_.lowerLimit = -2.5;
            __id8_.pathReturns = false;
            __id8_.speed1 = 0;
            __id8_.speed2 = 0;
            __id8_.speedFlag = "";
            __id8_.spring = true;
            __id8_.springConstant = 15;
            __id8_.springDamping = 0.5;
            __id8_.strength = 0;
            __id8_.targetName = "";
            __id8_.type = "RevolutePin";
            __id8_.upperLimit = 0.3;
            try
            {
                __id8_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_chest_DemoWorld1_Layer1_1()
        {
            try
            {
                chest["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            chest.bodyAllowSleep = true;
            chest.bodyAngularDamping = 0;
            chest.bodyApplyGravity = true;
            chest.bodyFixedRotation = false;
            chest.bodyIsBullet = false;
            chest.bodyIsSleeping = false;
            chest.bodyIsStatic = false;
            chest.bodyLinearDamping = 0;
            chest.shapeCategoryBits = "0x0004";
            chest.shapeDensity = 1;
            chest.shapeFriction = 0.2;
            chest.shapeGroupIndex = -10;
            chest.shapeIsSensor = false;
            chest.shapeMaskBits = "0xFFE9";
            chest.shapeRestitution = 0;
            try
            {
                chest["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_groundart_DemoWorld1_Layer1_1()
        {
            try
            {
                groundart["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            groundart.bodyAllowSleep = false;
            groundart.bodyAngularDamping = 0;
            groundart.bodyApplyGravity = false;
            groundart.bodyFixedRotation = true;
            groundart.bodyIsBullet = false;
            groundart.bodyIsSleeping = false;
            groundart.bodyIsStatic = true;
            groundart.bodyLinearDamping = 0;
            groundart.shapeCategoryBits = "0x0001";
            groundart.shapeDensity = 1;
            groundart.shapeFriction = 0.2;
            groundart.shapeGroupIndex = -10;
            groundart.shapeIsSensor = false;
            groundart.shapeMaskBits = "0xFFEF";
            groundart.shapeRestitution = 0;
            try
            {
                groundart["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_head_DemoWorld1_Layer1_1()
        {
            try
            {
                head["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            head.bodyAllowSleep = true;
            head.bodyAngularDamping = 0;
            head.bodyApplyGravity = true;
            head.bodyFixedRotation = true;
            head.bodyIsBullet = false;
            head.bodyIsSleeping = false;
            head.bodyIsStatic = false;
            head.bodyLinearDamping = 0;
            head.shapeCategoryBits = "0x0004";
            head.shapeDensity = 1;
            head.shapeFriction = 0.2;
            head.shapeGroupIndex = -10;
            head.shapeIsSensor = false;
            head.shapeMaskBits = "0xFFE9";
            head.shapeRestitution = 0;
            try
            {
                head["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_fleg_DemoWorld1_Layer1_1()
        {
            try
            {
                fleg["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            fleg.bodyAllowSleep = false;
            fleg.bodyAngularDamping = 0.5;
            fleg.bodyApplyGravity = true;
            fleg.bodyFixedRotation = false;
            fleg.bodyIsBullet = false;
            fleg.bodyIsSleeping = false;
            fleg.bodyIsStatic = false;
            fleg.bodyLinearDamping = 0;
            fleg.shapeCategoryBits = "0x0004";
            fleg.shapeDensity = 2;
            fleg.shapeFriction = 0.2;
            fleg.shapeGroupIndex = -10;
            fleg.shapeIsSensor = false;
            fleg.shapeMaskBits = "0xFFE9";
            fleg.shapeRestitution = 0;
            try
            {
                fleg["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_wicket_DemoWorld1_Layer1_1()
        {
            try
            {
                wicket["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            wicket.bodyAllowSleep = true;
            wicket.bodyAngularDamping = 0;
            wicket.bodyApplyGravity = true;
            wicket.bodyFixedRotation = false;
            wicket.bodyIsBullet = true;
            wicket.bodyIsSleeping = true;
            wicket.bodyIsStatic = false;
            wicket.bodyLinearDamping = 0;
            wicket.shapeCategoryBits = "0x0008";
            wicket.shapeDensity = 1;
            wicket.shapeFriction = 0.5;
            wicket.shapeGroupIndex = 0;
            wicket.shapeIsSensor = false;
            wicket.shapeMaskBits = "0xFFEB";
            wicket.shapeRestitution = 0.3;
            try
            {
                wicket["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_z4_b_DemoWorld1_Scorezones_1()
        {
            try
            {
                z4_b["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            z4_b.bodyAllowSleep = true;
            z4_b.bodyAngularDamping = 0;
            z4_b.bodyApplyGravity = true;
            z4_b.bodyFixedRotation = false;
            z4_b.bodyIsBullet = false;
            z4_b.bodyIsSleeping = false;
            z4_b.bodyIsStatic = true;
            z4_b.bodyLinearDamping = 0;
            z4_b.shapeCategoryBits = "0x0001";
            z4_b.shapeDensity = 1;
            z4_b.shapeFriction = 0.2;
            z4_b.shapeGroupIndex = 0;
            z4_b.shapeIsSensor = true;
            z4_b.shapeMaskBits = "0xFFFF";
            z4_b.shapeRestitution = 0;
            try
            {
                z4_b["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id5__DemoWorld1_Joints_1()
        {
            try
            {
                __id5_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id5_.body2Name = "bleg";
            __id5_.bodyName = "ground";
            __id5_.collideConnected = false;
            __id5_.enableLimit = true;
            __id5_.enableMotor = false;
            __id5_.lineParameter = "0x888888";
            __id5_.lineStyle = "Line";
            __id5_.lowerLimit = -0.2;
            __id5_.pathReturns = false;
            __id5_.speed1 = 0;
            __id5_.speed2 = 0;
            __id5_.speedFlag = "";
            __id5_.spring = true;
            __id5_.springConstant = 150;
            __id5_.springDamping = 0.8;
            __id5_.strength = 0;
            __id5_.targetName = "";
            __id5_.type = "RevolutePin";
            __id5_.upperLimit = 0.5;
            try
            {
                __id5_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_lshoulder_DemoWorld1_Layer1_1()
        {
            try
            {
                lshoulder["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            lshoulder.bodyAllowSleep = true;
            lshoulder.bodyAngularDamping = 0;
            lshoulder.bodyApplyGravity = false;
            lshoulder.bodyFixedRotation = false;
            lshoulder.bodyIsBullet = false;
            lshoulder.bodyIsSleeping = false;
            lshoulder.bodyIsStatic = false;
            lshoulder.bodyLinearDamping = 0;
            lshoulder.shapeCategoryBits = "0x0004";
            lshoulder.shapeDensity = 1.4;
            lshoulder.shapeFriction = 0.2;
            lshoulder.shapeGroupIndex = -10;
            lshoulder.shapeIsSensor = false;
            lshoulder.shapeMaskBits = "0xFFE9";
            lshoulder.shapeRestitution = 0;
            try
            {
                lshoulder["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id13__DemoWorld1_Joints_1()
        {
            try
            {
                __id13_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id13_.body2Name = "";
            __id13_.bodyName = "";
            __id13_.collideConnected = false;
            __id13_.enableLimit = false;
            __id13_.enableMotor = false;
            __id13_.lineParameter = "0x888888";
            __id13_.lineStyle = "Line";
            __id13_.lowerLimit = 0;
            __id13_.pathReturns = false;
            __id13_.speed1 = 0;
            __id13_.speed2 = 0;
            __id13_.speedFlag = "";
            __id13_.spring = false;
            __id13_.springConstant = 0;
            __id13_.springDamping = 0;
            __id13_.strength = 0;
            __id13_.targetName = "";
            __id13_.type = "RevolutePin";
            __id13_.upperLimit = 0;
            try
            {
                __id13_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id2__DemoWorld1_Joints_1()
        {
            try
            {
                __id2_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id2_.body2Name = "chest";
            __id2_.bodyName = "fthigh";
            __id2_.collideConnected = false;
            __id2_.enableLimit = true;
            __id2_.enableMotor = false;
            __id2_.lineParameter = "0x888888";
            __id2_.lineStyle = "Line";
            __id2_.lowerLimit = -0.3;
            __id2_.pathReturns = false;
            __id2_.speed1 = 0;
            __id2_.speed2 = 0;
            __id2_.speedFlag = "";
            __id2_.spring = true;
            __id2_.springConstant = 80;
            __id2_.springDamping = 0.8;
            __id2_.strength = 3;
            __id2_.targetName = "";
            __id2_.type = "RevolutePin";
            __id2_.upperLimit = 0.5;
            try
            {
                __id2_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_bat_DemoWorld1_Layer1_1()
        {
            try
            {
                bat["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            bat.bodyAllowSleep = false;
            bat.bodyAngularDamping = 0;
            bat.bodyApplyGravity = false;
            bat.bodyFixedRotation = false;
            bat.bodyIsBullet = true;
            bat.bodyIsSleeping = false;
            bat.bodyIsStatic = false;
            bat.bodyLinearDamping = 0;
            bat.shapeCategoryBits = "0x0010";
            bat.shapeDensity = 2;
            bat.shapeFriction = 0.2;
            bat.shapeGroupIndex = -10;
            bat.shapeIsSensor = false;
            bat.shapeMaskBits = "0xFFFA";
            bat.shapeRestitution = 0.5;
            try
            {
                bat["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_bleg_DemoWorld1_Layer1_1()
        {
            try
            {
                bleg["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            bleg.bodyAllowSleep = true;
            bleg.bodyAngularDamping = 0.5;
            bleg.bodyApplyGravity = true;
            bleg.bodyFixedRotation = false;
            bleg.bodyIsBullet = false;
            bleg.bodyIsSleeping = false;
            bleg.bodyIsStatic = false;
            bleg.bodyLinearDamping = 0;
            bleg.shapeCategoryBits = "0x0004";
            bleg.shapeDensity = 2;
            bleg.shapeFriction = 0.2;
            bleg.shapeGroupIndex = -10;
            bleg.shapeIsSensor = false;
            bleg.shapeMaskBits = "0xFFE9";
            bleg.shapeRestitution = 0;
            try
            {
                bleg["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_larm_DemoWorld1_Layer1_1()
        {
            try
            {
                larm["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            larm.bodyAllowSleep = true;
            larm.bodyAngularDamping = 0;
            larm.bodyApplyGravity = false;
            larm.bodyFixedRotation = false;
            larm.bodyIsBullet = false;
            larm.bodyIsSleeping = false;
            larm.bodyIsStatic = false;
            larm.bodyLinearDamping = 0;
            larm.shapeCategoryBits = "0x0004";
            larm.shapeDensity = 1;
            larm.shapeFriction = 0.2;
            larm.shapeGroupIndex = -10;
            larm.shapeIsSensor = false;
            larm.shapeMaskBits = "0xFFE9";
            larm.shapeRestitution = 0;
            try
            {
                larm["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id9__DemoWorld1_Joints_1()
        {
            try
            {
                __id9_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id9_.body2Name = "bat";
            __id9_.bodyName = "larm";
            __id9_.collideConnected = false;
            __id9_.enableLimit = true;
            __id9_.enableMotor = false;
            __id9_.lineParameter = "0x888888";
            __id9_.lineStyle = "Line";
            __id9_.lowerLimit = -0.5;
            __id9_.pathReturns = false;
            __id9_.speed1 = 0;
            __id9_.speed2 = 0;
            __id9_.speedFlag = "";
            __id9_.spring = true;
            __id9_.springConstant = 20;
            __id9_.springDamping = 0.5;
            __id9_.strength = 0;
            __id9_.targetName = "";
            __id9_.type = "RevolutePin";
            __id9_.upperLimit = 0.5;
            try
            {
                __id9_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id10__DemoWorld1_Joints_1()
        {
            try
            {
                __id10_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id10_.body2Name = "bat";
            __id10_.bodyName = "rarm";
            __id10_.collideConnected = false;
            __id10_.enableLimit = true;
            __id10_.enableMotor = false;
            __id10_.lineParameter = "0x888888";
            __id10_.lineStyle = "Line";
            __id10_.lowerLimit = -1.5;
            __id10_.pathReturns = false;
            __id10_.speed1 = 0;
            __id10_.speed2 = 0;
            __id10_.speedFlag = "";
            __id10_.spring = true;
            __id10_.springConstant = 20;
            __id10_.springDamping = 0.5;
            __id10_.strength = 0;
            __id10_.targetName = "";
            __id10_.type = "RevolutePin";
            __id10_.upperLimit = 1.5;
            try
            {
                __id10_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_bthigh_DemoWorld1_Layer1_1()
        {
            try
            {
                bthigh["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            bthigh.bodyAllowSleep = true;
            bthigh.bodyAngularDamping = 0;
            bthigh.bodyApplyGravity = true;
            bthigh.bodyFixedRotation = false;
            bthigh.bodyIsBullet = false;
            bthigh.bodyIsSleeping = false;
            bthigh.bodyIsStatic = false;
            bthigh.bodyLinearDamping = 0;
            bthigh.shapeCategoryBits = "0x0004";
            bthigh.shapeDensity = 1;
            bthigh.shapeFriction = 0.2;
            bthigh.shapeGroupIndex = -10;
            bthigh.shapeIsSensor = false;
            bthigh.shapeMaskBits = "0xFFE9";
            bthigh.shapeRestitution = 0;
            try
            {
                bthigh["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_zo_b_DemoWorld1_Scorezones_1()
        {
            try
            {
                zo_b["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            zo_b.bodyAllowSleep = true;
            zo_b.bodyAngularDamping = 0;
            zo_b.bodyApplyGravity = true;
            zo_b.bodyFixedRotation = false;
            zo_b.bodyIsBullet = false;
            zo_b.bodyIsSleeping = false;
            zo_b.bodyIsStatic = true;
            zo_b.bodyLinearDamping = 0;
            zo_b.shapeCategoryBits = "0x0001";
            zo_b.shapeDensity = 1;
            zo_b.shapeFriction = 0.2;
            zo_b.shapeGroupIndex = 0;
            zo_b.shapeIsSensor = true;
            zo_b.shapeMaskBits = "0xFFFF";
            zo_b.shapeRestitution = 0;
            try
            {
                zo_b["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_z6_a_DemoWorld1_Scorezones_1()
        {
            try
            {
                z6_a["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            z6_a.bodyAllowSleep = true;
            z6_a.bodyAngularDamping = 0;
            z6_a.bodyApplyGravity = true;
            z6_a.bodyFixedRotation = false;
            z6_a.bodyIsBullet = false;
            z6_a.bodyIsSleeping = false;
            z6_a.bodyIsStatic = true;
            z6_a.bodyLinearDamping = 0;
            z6_a.shapeCategoryBits = "0x0001";
            z6_a.shapeDensity = 1;
            z6_a.shapeFriction = 0.2;
            z6_a.shapeGroupIndex = 0;
            z6_a.shapeIsSensor = true;
            z6_a.shapeMaskBits = "0xFFFF";
            z6_a.shapeRestitution = 0;
            try
            {
                z6_a["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_z6_c_DemoWorld1_Scorezones_1()
        {
            try
            {
                z6_c["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            z6_c.bodyAllowSleep = true;
            z6_c.bodyAngularDamping = 0;
            z6_c.bodyApplyGravity = true;
            z6_c.bodyFixedRotation = false;
            z6_c.bodyIsBullet = false;
            z6_c.bodyIsSleeping = false;
            z6_c.bodyIsStatic = true;
            z6_c.bodyLinearDamping = 0;
            z6_c.shapeCategoryBits = "0x0001";
            z6_c.shapeDensity = 1;
            z6_c.shapeFriction = 0.2;
            z6_c.shapeGroupIndex = 0;
            z6_c.shapeIsSensor = true;
            z6_c.shapeMaskBits = "0xFFFF";
            z6_c.shapeRestitution = 0;
            try
            {
                z6_c["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id6__DemoWorld1_Joints_1()
        {
            try
            {
                __id6_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id6_.body2Name = "rshoulder";
            __id6_.bodyName = "chest";
            __id6_.collideConnected = false;
            __id6_.enableLimit = true;
            __id6_.enableMotor = false;
            __id6_.lineParameter = "0x888888";
            __id6_.lineStyle = "Line";
            __id6_.lowerLimit = -3;
            __id6_.pathReturns = false;
            __id6_.speed1 = 0;
            __id6_.speed2 = 0;
            __id6_.speedFlag = "";
            __id6_.spring = true;
            __id6_.springConstant = 50;
            __id6_.springDamping = 0.5;
            __id6_.strength = 1;
            __id6_.targetName = "";
            __id6_.type = "RevolutePin";
            __id6_.upperLimit = 3;
            try
            {
                __id6_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id3__DemoWorld1_Joints_1()
        {
            try
            {
                __id3_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id3_.body2Name = "chest";
            __id3_.bodyName = "bthigh";
            __id3_.collideConnected = false;
            __id3_.enableLimit = true;
            __id3_.enableMotor = false;
            __id3_.lineParameter = "0x888888";
            __id3_.lineStyle = "Line";
            __id3_.lowerLimit = -0.6;
            __id3_.pathReturns = false;
            __id3_.speed1 = 0;
            __id3_.speed2 = 0;
            __id3_.speedFlag = "";
            __id3_.spring = true;
            __id3_.springConstant = 80;
            __id3_.springDamping = 0.8;
            __id3_.strength = 3;
            __id3_.targetName = "";
            __id3_.type = "RevolutePin";
            __id3_.upperLimit = 0.3;
            try
            {
                __id3_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_bail_DemoWorld1_Layer1_1()
        {
            try
            {
                bail["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            bail.bodyAllowSleep = true;
            bail.bodyAngularDamping = 0;
            bail.bodyApplyGravity = true;
            bail.bodyFixedRotation = true;
            bail.bodyIsBullet = true;
            bail.bodyIsSleeping = true;
            bail.bodyIsStatic = false;
            bail.bodyLinearDamping = 0;
            bail.shapeCategoryBits = "0x0008";
            bail.shapeDensity = 1;
            bail.shapeFriction = 0.2;
            bail.shapeGroupIndex = 0;
            bail.shapeIsSensor = false;
            bail.shapeMaskBits = "0xFFEB";
            bail.shapeRestitution = 0.3;
            try
            {
                bail["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp___id0__DemoWorld1_Joints_1()
        {
            try
            {
                __id0_["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            __id0_.body2Name = "fthigh";
            __id0_.bodyName = "fleg";
            __id0_.collideConnected = false;
            __id0_.enableLimit = true;
            __id0_.enableMotor = false;
            __id0_.lineParameter = "0x888888";
            __id0_.lineStyle = "Line";
            __id0_.lowerLimit = -0.8;
            __id0_.pathReturns = false;
            __id0_.speed1 = 2;
            __id0_.speed2 = 2;
            __id0_.speedFlag = "";
            __id0_.spring = true;
            __id0_.springConstant = 80;
            __id0_.springDamping = 0.5;
            __id0_.strength = 5;
            __id0_.targetName = "";
            __id0_.type = "RevolutePin";
            __id0_.upperLimit = 0.3;
            try
            {
                __id0_["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_fthigh_DemoWorld1_Layer1_1()
        {
            try
            {
                fthigh["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            fthigh.bodyAllowSleep = false;
            fthigh.bodyAngularDamping = 0;
            fthigh.bodyApplyGravity = true;
            fthigh.bodyFixedRotation = false;
            fthigh.bodyIsBullet = false;
            fthigh.bodyIsSleeping = false;
            fthigh.bodyIsStatic = false;
            fthigh.bodyLinearDamping = 0;
            fthigh.shapeCategoryBits = "0x0004";
            fthigh.shapeDensity = 1;
            fthigh.shapeFriction = 0.2;
            fthigh.shapeGroupIndex = -10;
            fthigh.shapeIsSensor = false;
            fthigh.shapeMaskBits = "0xFFE9";
            fthigh.shapeRestitution = 0;
            try
            {
                fthigh["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function __setProp_z1_a_DemoWorld1_Scorezones_1()
        {
            try
            {
                z1_a["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            z1_a.bodyAllowSleep = true;
            z1_a.bodyAngularDamping = 0;
            z1_a.bodyApplyGravity = true;
            z1_a.bodyFixedRotation = false;
            z1_a.bodyIsBullet = false;
            z1_a.bodyIsSleeping = false;
            z1_a.bodyIsStatic = true;
            z1_a.bodyLinearDamping = 0;
            z1_a.shapeCategoryBits = "0x0001";
            z1_a.shapeDensity = 1;
            z1_a.shapeFriction = 0.2;
            z1_a.shapeGroupIndex = 0;
            z1_a.shapeIsSensor = true;
            z1_a.shapeMaskBits = "0xFFFF";
            z1_a.shapeRestitution = 0;
            try
            {
                z1_a["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
