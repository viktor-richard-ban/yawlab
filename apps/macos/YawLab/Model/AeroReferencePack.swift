//
//  AeroReferencePack.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 28..
//

import Foundation

/// A container for aerodynamic reference data anchored to
/// Ahmed Body / DrivAer benchmark studies.
///
/// An ``AeroReferencePack`` provides baseline aerodynamic coefficients
/// and simplified yaw-sensitivity models used to derive drag and
/// downforce from telemetry and wind-relative yaw.
///
/// This model is intentionally simplified and intended for
/// **scenario and sensitivity analysis**, not absolute prediction.
struct AeroReferencePack: Decodable {

    // MARK: - Metadata

    /// Unique identifier for this reference pack version.
    ///
    /// Used for traceability and reproducibility when comparing results
    /// across different model revisions.
    let id: String

    /// Human-readable name of the reference pack.
    let name: String
    
    /// Configuration version
    /// Using semantic versioning
    let version: String

    /// Source metadata describing where this reference data originates.
     let source: Source

    /// Units associated with all physical quantities used in this pack.
    ///
    /// Units are explicitly defined to avoid ambiguity when interpreting
    /// coefficients and forces.
     let units: Units

    /// Global default physical constants used by the aero model.
     let defaults: Defaults

    /// List of aerodynamic configurations supported by this pack.
    ///
    /// Each configuration represents a distinct aerodynamic setup
    /// (e.g. baseline, low-drag, high-downforce).
     let configs: [Config]
}

// MARK: - Source Metadata

 extension AeroReferencePack {

    /// Describes the provenance and assumptions of the aerodynamic model.
    struct Source: Decodable {

        /// Name or description of the benchmark dataset.
        ///
        /// Example: "Ahmed Body / DrivAer benchmark references".
         let dataset: String

        /// Free-form notes describing assumptions, simplifications,
        /// or intended usage of the reference data.
         let notes: String
    }
}

// MARK: - Units

 extension AeroReferencePack {

    /// Defines the units for physical quantities used by the reference pack.
    ///
    /// Explicit units help prevent misinterpretation of coefficients
    /// and derived forces.
    struct Units: Decodable {

        /// Unit used for aerodynamic yaw angle.
        ///
        /// Expected value: `"deg"` (degrees).
         let yaw: String

        /// Unit used for aerodynamic reference area.
        ///
        /// Expected value: `"m2"` (square meters).
         let area: String

        /// Unit used for air density.
        ///
        /// Expected value: `"kg/m3"`.
         let rho: String
    }
}

// MARK: - Defaults

 extension AeroReferencePack {

    /// Global default physical constants for aerodynamic calculations.
    struct Defaults: Decodable {

        /// Air density used for force calculations.
        ///
        /// Typically set to a standard sea-level value
        /// (e.g. 1.225 kg/m³) and assumed constant for the analysis.
         let rho: Double

        /// Aerodynamic reference area used to scale coefficients into forces.
        ///
        /// Often corresponds to a representative frontal area.
         let areaRef: Double

        private enum CodingKeys: String, CodingKey {
            case rho
            case areaRef = "area_ref"
        }
    }
}

// MARK: - Aerodynamic Configuration

 extension AeroReferencePack {

    /// Represents a specific aerodynamic configuration.
    ///
    /// Configurations differ by baseline coefficients and yaw sensitivity
    /// and are used to explore trade-offs such as drag vs downforce.
    struct Config: Decodable, Identifiable {

        /// Stable identifier for the configuration.
        ///
        /// Used internally for selection and persistence.
         let id: String

        /// Human-readable configuration name.
        ///
        /// Displayed in the UI.
         let displayName: String

        /// Baseline lift coefficient at zero yaw.
        ///
        /// Negative values represent downforce.
         let cl0: Double

        /// Baseline drag coefficient at zero yaw.
         let cd0: Double

        /// Yaw sensitivity model defining how coefficients vary with yaw.
         let yawModel: YawModel
        
         init(id: String, displayName: String, cl0: Double, cd0: Double, yawModel: YawModel) {
            self.id = id
            self.displayName = displayName
            self.cl0 = cl0
            self.cd0 = cd0
            self.yawModel = yawModel
        }

        private enum CodingKeys: String, CodingKey {
            case id
            case displayName = "display_name"
            case cl0
            case cd0
            case yawModel = "yaw_model"
        }
    }
}

// MARK: - Yaw Sensitivity Model

 extension AeroReferencePack {

    /// Defines how aerodynamic coefficients change as a function of yaw.
    ///
    /// For the MVP, a quadratic model is used, assuming symmetric
    /// behavior for positive and negative yaw angles.
    struct YawModel: Decodable {

        /// Mathematical form of the yaw sensitivity model.
        ///
        /// Currently supported:
        /// - `"quadratic"`: coefficient varies with yaw²
         let type: String

        /// Coefficient controlling drag increase with yaw squared.
        ///
        /// Drag coefficient is computed as:
        /// ```
        /// CD = CD0 + kCdYaw2 * yaw²
        /// ```
         let kCdYaw2: Double

        /// Coefficient controlling lift/downforce change with yaw squared.
        ///
        /// Lift coefficient is computed as:
        /// ```
        /// CL = CL0 + kClYaw2 * yaw²
        /// ```
         let kClYaw2: Double

        private enum CodingKeys: String, CodingKey {
            case type
            case kCdYaw2 = "k_cd_yaw2"
            case kClYaw2 = "k_cl_yaw2"
        }
    }
}
