//
//  Dehydratable+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 20/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

struct Star: Dehydratable, Hydratable {
    var name: String
    var mass: Float
    var stellarClassification: String
    
    func dehydrate() -> [String : Any] {
        return ["name": name, "mass": mass, "stellarClassification": stellarClassification]
    }

    static func hydrate(_ hydrated: inout Star?, source data: [String : Any]) throws {
        hydrated = Star(
            name: try data.hydrate("name"),
            mass: try data.hydrate("mass"),
            stellarClassification: try data.hydrate("stellarClassification")
        )
    }
}

struct Planet: Dehydratable, Hydratable {
    var name: String
    var mass: Float
    
    init(name: String, mass: Float) {
        self.name = name
        self.mass = mass
    }
    
    func dehydrate() -> [String : Any] {
        return ["name": name, "mass": mass]
    }
    
    static func hydrate(_ hydrated: inout Planet?, source data: [String : Any]) throws {
        hydrated = Planet(
            name: try data.hydrate("name"),
            mass: try data.hydrate("mass")
        )
    }
}

struct SolarSystem: Dehydratable, Hydratable {
    var star: Star
    var planets: [Planet]
    
    func dehydrate() -> [String : Any] {
        return ["star": star.dehydrate(), "planets": planets.dehydrate()]
    }
    
    static func hydrate(_ hydrated: inout SolarSystem?, source data: [String : Any]) throws {
        hydrated = SolarSystem(
            star: try data.hydrate("star"),
            planets: try data.hydrate("planets")
        )
    }
}

struct NotDehydratable: Dehydratable {
    var notJsonObject = CGColor.aliceBlue
    
    func dehydrate() -> [String : Any] {
        return ["notJsonObject": notJsonObject]
    }
}

class Dehydratable_Tests: XCTestCase {
    
    // WIP
    
//    func test_rehydratable() {
//        let star: Star = Star(
//            name: "Sun",
//            mass: 10,
//            stellarClassification: "Big"
//        )
//        let solarSystem = SolarSystem(
//            star: star,
//            planets: [
//                Planet(name: "Earth", mass: 1),
//                Planet(name: "Mars", mass: 1)
//            ]
//        )
//
//        guard let hydratedStar = star.hydratedDehydratedSelf,
//            hydratedSolarSystem = solarSystem.hydratedDehydratedSelf else { fail(); return }
//        
//        assert(hydratedStar) == star
//        assert(hydratedSolarSystem) == solarSystem
//        
//
//    }
//    
//    func test_not_a_json_object() {
//        let promise = expectation()
//        
//        let notDehydratable = NotDehydratable()
//        
//        if notDehydratable.description != nil {
//            promise.fulfill()
//        }
//        
//        wait(for: 1)
//    }
}
