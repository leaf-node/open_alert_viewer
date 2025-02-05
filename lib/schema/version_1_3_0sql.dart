/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

final version_1_3_0sql = """

ALTER TABLE sources ADD COLUMN visible BOOLEAN NOT NULL DEFAULT true;
ALTER TABLE sources ADD COLUMN notifications BOOLEAN NOT NULL DEFAULT true;

UPDATE sources SET (visible, notifications) = (true, true);

""";
