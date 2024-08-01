/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

CREATE TABLE IF NOT EXISTS sources (
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    type INTEGER NOT NULL,
    base_url TEXT NOT NULL,
    path TEXT NOT NULL,
    username TEXT NOT NULL,
    password TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS settings (
    id INTEGER NOT NULL PRIMARY KEY,
    key TEXT NOT NULL UNIQUE,
    value TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS alerts_cache (
    id INTEGER NOT NULL PRIMARY KEY,
    source INTEGER NOT NULL,
    kind INTEGER NOT NULL,
    hostname TEXT NOT NULL,
    service TEXT NOT NULL,
    message TEXT NOT NULL,
    age INTEGER NOT NULL
);
